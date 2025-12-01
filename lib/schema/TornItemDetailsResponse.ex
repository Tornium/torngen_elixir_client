defmodule Torngen.Client.Schema.TornItemDetailsResponse do
  @moduledoc false

  use Torngen.Client.SchemaObjectAccess, deprecated: []

  @behaviour Torngen.Client.Schema

  @keys [:itemdetails]

  defstruct [
    :itemdetails
  ]

  @type t :: %__MODULE__{
          itemdetails: Torngen.Client.Schema.TornItemDetails.t()
        }

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      itemdetails:
        data
        |> Map.get("itemdetails")
        |> Torngen.Client.Schema.parse(Torngen.Client.Schema.TornItemDetails)
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

  defp validate_key?(:itemdetails, value) do
    Torngen.Client.Schema.validate?(value, Torngen.Client.Schema.TornItemDetails)
  end

  @spec keys() :: list(atom())
  def keys(), do: @keys
end
