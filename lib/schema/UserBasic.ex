defmodule Torngen.Client.Schema.UserBasic do
  @moduledoc false

  use Torngen.Client.SchemaObjectAccess, deprecated: []

  @behaviour Torngen.Client.Schema

  @keys [:status, :name, :level, :id, :gender]

  defstruct [
    :status,
    :name,
    :level,
    :id,
    :gender
  ]

  @type t :: %__MODULE__{
          status: Torngen.Client.Schema.UserStatus.t(),
          name: String.t(),
          level: integer(),
          id: Torngen.Client.Schema.UserId.t(),
          gender: Torngen.Client.Schema.UserGenderEnum.t()
        }

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      status:
        data
        |> Map.get("status")
        |> Torngen.Client.Schema.parse({:ref, Torngen.Client.Schema.UserStatus}),
      name: data |> Map.get("name") |> Torngen.Client.Schema.parse({:static, :string}),
      level: data |> Map.get("level") |> Torngen.Client.Schema.parse({:static, :integer}),
      id:
        data |> Map.get("id") |> Torngen.Client.Schema.parse({:ref, Torngen.Client.Schema.UserId}),
      gender:
        data
        |> Map.get("gender")
        |> Torngen.Client.Schema.parse({:ref, Torngen.Client.Schema.UserGenderEnum})
    }
  end

  @impl true
  def parse(_data), do: nil

  @impl true
  def validate?(%{} = data) do
    @keys
    |> Enum.map(fn key -> {key, Map.get(data, Atom.to_string(key))} end)
    |> Enum.map(fn {key, value} -> validate_key?(key, value) end)
    |> Enum.all?()
  end

  defp validate_key?(:status, value) do
    Torngen.Client.Schema.validate?(value, {:ref, Torngen.Client.Schema.UserStatus})
  end

  defp validate_key?(:name, value) do
    Torngen.Client.Schema.validate?(value, {:static, :string})
  end

  defp validate_key?(:level, value) do
    Torngen.Client.Schema.validate?(value, {:static, :integer})
  end

  defp validate_key?(:id, value) do
    Torngen.Client.Schema.validate?(value, {:ref, Torngen.Client.Schema.UserId})
  end

  defp validate_key?(:gender, value) do
    Torngen.Client.Schema.validate?(value, {:ref, Torngen.Client.Schema.UserGenderEnum})
  end

  @spec keys() :: list(atom())
  def keys(), do: @keys
end
