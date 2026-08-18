defmodule Torngen.Client.Schema.TornBankResponse do
  @moduledoc false

  use Torngen.Client.SchemaObjectAccess, deprecated: []

  @behaviour Torngen.Client.Schema

  @keys [:bank]

  defstruct [
    :bank
  ]

  @type t :: %__MODULE__{
          bank: [Torngen.Client.Schema.TornBank.t()]
        }

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      bank:
        data
        |> Map.get("bank")
        |> Torngen.Client.Schema.parse({:array, {:ref, Torngen.Client.Schema.TornBank}})
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

  defp validate_key?(:bank, value) do
    Torngen.Client.Schema.validate?(value, {:array, {:ref, Torngen.Client.Schema.TornBank}})
  end

  @spec keys() :: list(atom())
  def keys(), do: @keys
end
