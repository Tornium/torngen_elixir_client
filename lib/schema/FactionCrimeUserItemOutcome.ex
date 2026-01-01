defmodule Torngen.Client.Schema.FactionCrimeUserItemOutcome do
  @moduledoc false

  use Torngen.Client.SchemaObjectAccess, deprecated: []

  @behaviour Torngen.Client.Schema

  @keys [:owned_by, :outcome, :item_uid, :item_id]

  defstruct [
    :owned_by,
    :outcome,
    :item_uid,
    :item_id
  ]

  @type t :: %__MODULE__{
          owned_by: Torngen.Client.Schema.FactionCrimeUserItemOutcomeEnum.t(),
          outcome: Torngen.Client.Schema.FactionCrimeItemOutcomeEnum.t(),
          item_uid: Torngen.Client.Schema.ItemUid.t(),
          item_id: Torngen.Client.Schema.ItemId.t()
        }

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      owned_by:
        data
        |> Map.get("owned_by")
        |> Torngen.Client.Schema.parse(
          {:ref, Torngen.Client.Schema.FactionCrimeUserItemOutcomeEnum}
        ),
      outcome:
        data
        |> Map.get("outcome")
        |> Torngen.Client.Schema.parse({:ref, Torngen.Client.Schema.FactionCrimeItemOutcomeEnum}),
      item_uid:
        data
        |> Map.get("item_uid")
        |> Torngen.Client.Schema.parse({:ref, Torngen.Client.Schema.ItemUid}),
      item_id:
        data
        |> Map.get("item_id")
        |> Torngen.Client.Schema.parse({:ref, Torngen.Client.Schema.ItemId})
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

  defp validate_key?(:owned_by, value) do
    Torngen.Client.Schema.validate?(
      value,
      {:ref, Torngen.Client.Schema.FactionCrimeUserItemOutcomeEnum}
    )
  end

  defp validate_key?(:outcome, value) do
    Torngen.Client.Schema.validate?(
      value,
      {:ref, Torngen.Client.Schema.FactionCrimeItemOutcomeEnum}
    )
  end

  defp validate_key?(:item_uid, value) do
    Torngen.Client.Schema.validate?(value, {:ref, Torngen.Client.Schema.ItemUid})
  end

  defp validate_key?(:item_id, value) do
    Torngen.Client.Schema.validate?(value, {:ref, Torngen.Client.Schema.ItemId})
  end

  @spec keys() :: list(atom())
  def keys(), do: @keys
end
