defmodule Torngen.Client.Schema.BazaarSpecialized do
  @moduledoc false

  use Torngen.Client.SchemaObjectAccess, deprecated: []

  @behaviour Torngen.Client.Schema

  @keys [:specialized]

  defstruct [
    :specialized
  ]

  @type t :: %__MODULE__{
          specialized: [Torngen.Client.Schema.BazaarWeeklyCustomers.t()]
        }

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      specialized:
        data
        |> Map.get("specialized")
        |> Torngen.Client.Schema.parse({:array, Torngen.Client.Schema.BazaarWeeklyCustomers})
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

  defp validate_key?(:specialized, value) do
    Torngen.Client.Schema.validate?(value, {:array, Torngen.Client.Schema.BazaarWeeklyCustomers})
  end

  @spec keys() :: list(atom())
  def keys(), do: @keys
end
