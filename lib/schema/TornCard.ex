defmodule Torngen.Client.Schema.TornCard do
  @moduledoc false

  use Torngen.Client.SchemaObjectAccess, deprecated: []

  @behaviour Torngen.Client.Schema

  @keys [:short_name, :name, :class]

  defstruct [
    :short_name,
    :name,
    :class
  ]

  @type t :: %__MODULE__{
          short_name: String.t(),
          name: String.t(),
          class: String.t()
        }

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      short_name:
        data |> Map.get("short_name") |> Torngen.Client.Schema.parse({:static, :string}),
      name: data |> Map.get("name") |> Torngen.Client.Schema.parse({:static, :string}),
      class: data |> Map.get("class") |> Torngen.Client.Schema.parse({:static, :string})
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

  defp validate_key?(:short_name, value) do
    Torngen.Client.Schema.validate?(value, {:static, :string})
  end

  defp validate_key?(:name, value) do
    Torngen.Client.Schema.validate?(value, {:static, :string})
  end

  defp validate_key?(:class, value) do
    Torngen.Client.Schema.validate?(value, {:static, :string})
  end

  @spec keys() :: list(atom())
  def keys(), do: @keys
end
