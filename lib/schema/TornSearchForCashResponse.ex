defmodule Torngen.Client.Schema.TornSearchForCashResponse do
  @moduledoc false

  use Torngen.Client.SchemaObjectAccess, deprecated: []

  @behaviour Torngen.Client.Schema

  @keys [:searchforcash]

  defstruct [
    :searchforcash
  ]

  @type t :: %__MODULE__{
          searchforcash: [Torngen.Client.Schema.TornSearchForCash.t()]
        }

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      searchforcash:
        data
        |> Map.get("searchforcash")
        |> Torngen.Client.Schema.parse({:array, {:ref, Torngen.Client.Schema.TornSearchForCash}})
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

  defp validate_key?(:searchforcash, value) do
    Torngen.Client.Schema.validate?(
      value,
      {:array, {:ref, Torngen.Client.Schema.TornSearchForCash}}
    )
  end

  @spec keys() :: list(atom())
  def keys(), do: @keys
end
