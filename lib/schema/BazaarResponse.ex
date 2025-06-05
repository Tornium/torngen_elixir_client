defmodule Torngen.Client.Schema.BazaarResponse do
  @moduledoc false

  use Torngen.Client.SchemaObjectAccess, deprecated: []

  @behaviour Torngen.Client.Schema

  @keys [:bazaar]

  defstruct [
    :bazaar
  ]

  @type t :: %__MODULE__{
          bazaar:
            Torngen.Client.Schema.BazaarSpecialized.t() | Torngen.Client.Schema.BazaarWeekly.t()
        }

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      bazaar:
        data
        |> Map.get("bazaar")
        |> Torngen.Client.Schema.parse(
          {:one_of, [Torngen.Client.Schema.BazaarSpecialized, Torngen.Client.Schema.BazaarWeekly]}
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

  defp validate_key?(:bazaar, value) do
    Torngen.Client.Schema.validate?(
      value,
      {:one_of, [Torngen.Client.Schema.BazaarSpecialized, Torngen.Client.Schema.BazaarWeekly]}
    )
  end

  @spec keys() :: list(atom())
  def keys(), do: @keys
end
