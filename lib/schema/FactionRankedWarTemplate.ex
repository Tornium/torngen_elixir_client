defmodule Torngen.Client.Schema.FactionRankedWarTemplate do
  @moduledoc false

  use Torngen.Client.SchemaObjectAccess, deprecated: []

  @behaviour Torngen.Client.Schema

  @keys [:rules, :mode]

  defstruct [
    :rules,
    :mode
  ]

  @type t :: %__MODULE__{
          rules: [Torngen.Client.Schema.FactionRankedWarRule.t()],
          mode: nil | Torngen.Client.Schema.FactionRankedWarMode.t()
        }

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      rules:
        data
        |> Map.get("rules")
        |> Torngen.Client.Schema.parse(
          {:array, {:ref, Torngen.Client.Schema.FactionRankedWarRule}}
        ),
      mode:
        data
        |> Map.get("mode")
        |> Torngen.Client.Schema.parse(
          {:one_of, [static: :null, ref: Torngen.Client.Schema.FactionRankedWarMode]}
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
      {:array, {:ref, Torngen.Client.Schema.FactionRankedWarRule}}
    )
  end

  defp validate_key?(:mode, value) do
    Torngen.Client.Schema.validate?(
      value,
      {:one_of, [static: :null, ref: Torngen.Client.Schema.FactionRankedWarMode]}
    )
  end

  @spec keys() :: list(atom())
  def keys(), do: @keys
end
