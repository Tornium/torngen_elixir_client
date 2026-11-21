defmodule Torngen.Client.Schema.UserUnlockedGym do
  @moduledoc false

  use Torngen.Client.SchemaObjectAccess, deprecated: []

  @behaviour Torngen.Client.Schema

  @keys [:name, :id, :available]

  defstruct [
    :name,
    :id,
    :available
  ]

  @type t :: %__MODULE__{
          name: String.t(),
          id: Torngen.Client.Schema.GymId.t(),
          available: boolean()
        }

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      name: data |> Map.get("name") |> Torngen.Client.Schema.parse({:static, :string}),
      id:
        data |> Map.get("id") |> Torngen.Client.Schema.parse({:ref, Torngen.Client.Schema.GymId}),
      available: data |> Map.get("available") |> Torngen.Client.Schema.parse({:static, :boolean})
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

  defp validate_key?(:name, value) do
    Torngen.Client.Schema.validate?(value, {:static, :string})
  end

  defp validate_key?(:id, value) do
    Torngen.Client.Schema.validate?(value, {:ref, Torngen.Client.Schema.GymId})
  end

  defp validate_key?(:available, value) do
    Torngen.Client.Schema.validate?(value, {:static, :boolean})
  end

  @spec keys() :: list(atom())
  def keys(), do: @keys
end
