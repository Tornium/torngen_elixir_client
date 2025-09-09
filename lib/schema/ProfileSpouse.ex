defmodule Torngen.Client.Schema.ProfileSpouse do
  @moduledoc false

  use Torngen.Client.SchemaObjectAccess, deprecated: []

  @behaviour Torngen.Client.Schema

  @keys [:status, :name, :id, :days_married]

  defstruct [
    :status,
    :name,
    :id,
    :days_married
  ]

  @type t :: %__MODULE__{
          status: Torngen.Client.Schema.UserMaritalStatusEnum.t(),
          name: String.t(),
          id: Torngen.Client.Schema.UserId.t(),
          days_married: integer()
        }

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      status:
        data
        |> Map.get("status")
        |> Torngen.Client.Schema.parse(Torngen.Client.Schema.UserMaritalStatusEnum),
      name: data |> Map.get("name") |> Torngen.Client.Schema.parse({:static, :string}),
      id: data |> Map.get("id") |> Torngen.Client.Schema.parse(Torngen.Client.Schema.UserId),
      days_married:
        data |> Map.get("days_married") |> Torngen.Client.Schema.parse({:static, :integer})
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
    Torngen.Client.Schema.validate?(value, Torngen.Client.Schema.UserMaritalStatusEnum)
  end

  defp validate_key?(:name, value) do
    Torngen.Client.Schema.validate?(value, {:static, :string})
  end

  defp validate_key?(:id, value) do
    Torngen.Client.Schema.validate?(value, Torngen.Client.Schema.UserId)
  end

  defp validate_key?(:days_married, value) do
    Torngen.Client.Schema.validate?(value, {:static, :integer})
  end

  @spec keys() :: list(atom())
  def keys(), do: @keys
end
