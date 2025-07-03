defmodule Torngen.Client.Schema.TornOrganizedCrimeSlot do
  @moduledoc false

  use Torngen.Client.SchemaObjectAccess, deprecated: []

  @behaviour Torngen.Client.Schema

  @keys [:required_item, :name, :id]

  defstruct [
    :required_item,
    :name,
    :id
  ]

  @type t :: %__MODULE__{
          required_item: nil | Torngen.Client.Schema.TornOrganizedCrimeRequiredItem.t(),
          name: String.t(),
          id: String.t()
        }

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      required_item:
        data
        |> Map.get("required_item")
        |> Torngen.Client.Schema.parse(
          {:one_of, [{:static, :null}, Torngen.Client.Schema.TornOrganizedCrimeRequiredItem]}
        ),
      name: data |> Map.get("name") |> Torngen.Client.Schema.parse({:static, :string}),
      id: data |> Map.get("id") |> Torngen.Client.Schema.parse({:static, :string})
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

  defp validate_key?(:required_item, value) do
    Torngen.Client.Schema.validate?(
      value,
      {:one_of, [{:static, :null}, Torngen.Client.Schema.TornOrganizedCrimeRequiredItem]}
    )
  end

  defp validate_key?(:name, value) do
    Torngen.Client.Schema.validate?(value, {:static, :string})
  end

  defp validate_key?(:id, value) do
    Torngen.Client.Schema.validate?(value, {:static, :string})
  end

  @spec keys() :: list(atom())
  def keys(), do: @keys
end
