defmodule Torngen.Client.Schema.UserBountiesResponse do
  @moduledoc false

  use Torngen.Client.SchemaObjectAccess, deprecated: []

  @behaviour Torngen.Client.Schema

  @keys [:bounties]

  defstruct [
    :bounties
  ]

  @type t :: %__MODULE__{
          bounties: [Torngen.Client.Schema.Bounty.t()]
        }

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      bounties:
        data
        |> Map.get("bounties")
        |> Torngen.Client.Schema.parse({:array, Torngen.Client.Schema.Bounty})
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

  defp validate_key?(:bounties, value) do
    Torngen.Client.Schema.validate?(value, {:array, Torngen.Client.Schema.Bounty})
  end

  @spec keys() :: list(atom())
  def keys(), do: @keys
end
