defmodule Torngen.Client.Schema.TornHeadlinesResponse do
  @moduledoc false

  use Torngen.Client.SchemaObjectAccess, deprecated: []

  @behaviour Torngen.Client.Schema

  @keys [:headlines]

  defstruct [
    :headlines
  ]

  @type t :: %__MODULE__{
          headlines: [Torngen.Client.Schema.TornHeadline.t()]
        }

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      headlines:
        data
        |> Map.get("headlines")
        |> Torngen.Client.Schema.parse({:array, {:ref, Torngen.Client.Schema.TornHeadline}})
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

  defp validate_key?(:headlines, value) do
    Torngen.Client.Schema.validate?(value, {:array, {:ref, Torngen.Client.Schema.TornHeadline}})
  end

  @spec keys() :: list(atom())
  def keys(), do: @keys
end
