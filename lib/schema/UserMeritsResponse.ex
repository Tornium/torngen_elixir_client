defmodule Torngen.Client.Schema.UserMeritsResponse do
  @moduledoc false

  use Torngen.Client.SchemaObjectAccess, deprecated: []

  @behaviour Torngen.Client.Schema

  @keys [:merits]

  defstruct [
    :merits
  ]

  @type t :: %__MODULE__{
          merits: Torngen.Client.Schema.UserMerits.t()
        }

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      merits:
        data |> Map.get("merits") |> Torngen.Client.Schema.parse(Torngen.Client.Schema.UserMerits)
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

  defp validate_key?(:merits, value) do
    Torngen.Client.Schema.validate?(value, Torngen.Client.Schema.UserMerits)
  end

  @spec keys() :: list(atom())
  def keys(), do: @keys
end
