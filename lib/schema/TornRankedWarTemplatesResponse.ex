defmodule Torngen.Client.Schema.TornRankedWarTemplatesResponse do
  @moduledoc false

  use Torngen.Client.SchemaObjectAccess, deprecated: []

  @behaviour Torngen.Client.Schema

  @keys [:rankedwartemplates]

  defstruct [
    :rankedwartemplates
  ]

  @type t :: %__MODULE__{
          rankedwartemplates: Torngen.Client.Schema.TornRankedWarTemplates.t()
        }

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      rankedwartemplates:
        data
        |> Map.get("rankedwartemplates")
        |> Torngen.Client.Schema.parse({:ref, Torngen.Client.Schema.TornRankedWarTemplates})
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

  defp validate_key?(:rankedwartemplates, value) do
    Torngen.Client.Schema.validate?(value, {:ref, Torngen.Client.Schema.TornRankedWarTemplates})
  end

  @spec keys() :: list(atom())
  def keys(), do: @keys
end
