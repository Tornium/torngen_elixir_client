defmodule Torngen.Client.Schema.FactionSlotPositionInfo do
  @moduledoc false

  use Torngen.Client.SchemaObjectAccess, deprecated: [:number]

  @behaviour Torngen.Client.Schema

  @keys [:number, :label, :id]

  defstruct [
    :number,
    :label,
    :id
  ]

  @type t :: %__MODULE__{
          number: integer(),
          label: String.t(),
          id: Torngen.Client.Schema.TornOrganizedCrimePositionId.t()
        }

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      number: data |> Map.get("number") |> Torngen.Client.Schema.parse({:static, :integer}),
      label: data |> Map.get("label") |> Torngen.Client.Schema.parse({:static, :string}),
      id:
        data
        |> Map.get("id")
        |> Torngen.Client.Schema.parse({:ref, Torngen.Client.Schema.TornOrganizedCrimePositionId})
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

  defp validate_key?(:number, value) do
    Torngen.Client.Schema.validate?(value, {:static, :integer})
  end

  defp validate_key?(:label, value) do
    Torngen.Client.Schema.validate?(value, {:static, :string})
  end

  defp validate_key?(:id, value) do
    Torngen.Client.Schema.validate?(
      value,
      {:ref, Torngen.Client.Schema.TornOrganizedCrimePositionId}
    )
  end

  @spec keys() :: list(atom())
  def keys(), do: @keys
end
