defmodule Torngen.Client.Schema.TornGymsResponse do
  @moduledoc false

  use Torngen.Client.SchemaObjectAccess, deprecated: []

  @behaviour Torngen.Client.Schema

  @keys [:gyms]

  defstruct [
    :gyms
  ]

  @type t :: %__MODULE__{
          gyms: [Torngen.Client.Schema.TornGym.t()]
        }

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      gyms:
        data
        |> Map.get("gyms")
        |> Torngen.Client.Schema.parse({:array, {:ref, Torngen.Client.Schema.TornGym}})
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

  defp validate_key?(:gyms, value) do
    Torngen.Client.Schema.validate?(value, {:array, {:ref, Torngen.Client.Schema.TornGym}})
  end

  @spec keys() :: list(atom())
  def keys(), do: @keys
end
