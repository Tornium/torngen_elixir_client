defmodule Torngen.Client.Schema.FactionOcHistoryRole do
  @moduledoc false

  use Torngen.Client.SchemaObjectAccess, deprecated: []

  @behaviour Torngen.Client.Schema

  @keys [:label, :id]

  defstruct [
    :label,
    :id
  ]

  @type t :: %__MODULE__{
          label: String.t(),
          id: nil | Torngen.Client.Schema.TornOrganizedCrimePositionId.t()
        }

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      label: data |> Map.get("label") |> Torngen.Client.Schema.parse({:static, :string}),
      id:
        data
        |> Map.get("id")
        |> Torngen.Client.Schema.parse(
          {:one_of, [static: :null, ref: Torngen.Client.Schema.TornOrganizedCrimePositionId]}
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

  defp validate_key?(:label, value) do
    Torngen.Client.Schema.validate?(value, {:static, :string})
  end

  defp validate_key?(:id, value) do
    Torngen.Client.Schema.validate?(
      value,
      {:one_of, [static: :null, ref: Torngen.Client.Schema.TornOrganizedCrimePositionId]}
    )
  end

  @spec keys() :: list(atom())
  def keys(), do: @keys
end
