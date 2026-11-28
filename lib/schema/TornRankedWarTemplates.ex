defmodule Torngen.Client.Schema.TornRankedWarTemplates do
  @moduledoc false

  use Torngen.Client.SchemaObjectAccess, deprecated: []

  @behaviour Torngen.Client.Schema

  @keys [:rules, :modes]

  defstruct [
    :rules,
    :modes
  ]

  @type t :: %__MODULE__{
          rules: [Torngen.Client.Schema.TornRankedWarTemplateEntry.t()],
          modes: [Torngen.Client.Schema.TornRankedWarTemplateEntry.t()]
        }

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      rules:
        data
        |> Map.get("rules")
        |> Torngen.Client.Schema.parse(
          {:array, {:ref, Torngen.Client.Schema.TornRankedWarTemplateEntry}}
        ),
      modes:
        data
        |> Map.get("modes")
        |> Torngen.Client.Schema.parse(
          {:array, {:ref, Torngen.Client.Schema.TornRankedWarTemplateEntry}}
        )
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

  defp validate_key?(:rules, value) do
    Torngen.Client.Schema.validate?(
      value,
      {:array, {:ref, Torngen.Client.Schema.TornRankedWarTemplateEntry}}
    )
  end

  defp validate_key?(:modes, value) do
    Torngen.Client.Schema.validate?(
      value,
      {:array, {:ref, Torngen.Client.Schema.TornRankedWarTemplateEntry}}
    )
  end

  @spec keys() :: list(atom())
  def keys(), do: @keys
end
