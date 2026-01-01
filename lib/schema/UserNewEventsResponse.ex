defmodule Torngen.Client.Schema.UserNewEventsResponse do
  @moduledoc false

  use Torngen.Client.SchemaObjectAccess, deprecated: []

  @behaviour Torngen.Client.Schema

  @keys [:events]

  defstruct [
    :events
  ]

  @type t :: %__MODULE__{
          events: [Torngen.Client.Schema.UserEvent.t()]
        }

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      events:
        data
        |> Map.get("events")
        |> Torngen.Client.Schema.parse({:array, {:ref, Torngen.Client.Schema.UserEvent}})
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

  defp validate_key?(:events, value) do
    Torngen.Client.Schema.validate?(value, {:array, {:ref, Torngen.Client.Schema.UserEvent}})
  end

  @spec keys() :: list(atom())
  def keys(), do: @keys
end
