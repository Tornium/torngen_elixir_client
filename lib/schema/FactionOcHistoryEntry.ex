defmodule Torngen.Client.Schema.FactionOcHistoryEntry do
  @moduledoc false

  use Torngen.Client.SchemaObjectAccess, deprecated: []

  @behaviour Torngen.Client.Schema

  @keys [:user, :timestamp, :text, :performed_by, :id, :details, :action]

  defstruct [
    :user,
    :timestamp,
    :text,
    :performed_by,
    :id,
    :details,
    :action
  ]

  @type t :: %__MODULE__{
          user: nil | Torngen.Client.Schema.BasicUser.t(),
          timestamp: integer(),
          text: String.t(),
          performed_by: nil | Torngen.Client.Schema.BasicUser.t(),
          id: integer(),
          details:
            nil
            | Torngen.Client.Schema.FactionOcHistoryPayoutReceivedDetails.t()
            | Torngen.Client.Schema.FactionOcHistoryPayoutDetails.t()
            | Torngen.Client.Schema.FactionOcHistoryInjuryDetails.t()
            | Torngen.Client.Schema.FactionOcHistoryPunishmentDetails.t()
            | Torngen.Client.Schema.FactionOcHistoryItem.t()
            | Torngen.Client.Schema.FactionOcHistorySpawnDetails.t()
            | Torngen.Client.Schema.FactionOcHistoryRoleChangeDetails.t()
            | Torngen.Client.Schema.FactionOcHistoryRoleDetails.t(),
          action: Torngen.Client.Schema.FactionOcHistoryActionEnum.t()
        }

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      user:
        data
        |> Map.get("user")
        |> Torngen.Client.Schema.parse(
          {:one_of, [static: :null, ref: Torngen.Client.Schema.BasicUser]}
        ),
      timestamp: data |> Map.get("timestamp") |> Torngen.Client.Schema.parse({:static, :integer}),
      text: data |> Map.get("text") |> Torngen.Client.Schema.parse({:static, :string}),
      performed_by:
        data
        |> Map.get("performed_by")
        |> Torngen.Client.Schema.parse(
          {:one_of, [static: :null, ref: Torngen.Client.Schema.BasicUser]}
        ),
      id: data |> Map.get("id") |> Torngen.Client.Schema.parse({:static, :integer}),
      details:
        data
        |> Map.get("details")
        |> Torngen.Client.Schema.parse(
          {:one_of,
           [
             static: :null,
             ref: Torngen.Client.Schema.FactionOcHistoryPayoutReceivedDetails,
             ref: Torngen.Client.Schema.FactionOcHistoryPayoutDetails,
             ref: Torngen.Client.Schema.FactionOcHistoryInjuryDetails,
             ref: Torngen.Client.Schema.FactionOcHistoryPunishmentDetails,
             ref: Torngen.Client.Schema.FactionOcHistoryItem,
             ref: Torngen.Client.Schema.FactionOcHistorySpawnDetails,
             ref: Torngen.Client.Schema.FactionOcHistoryRoleChangeDetails,
             ref: Torngen.Client.Schema.FactionOcHistoryRoleDetails
           ]}
        ),
      action:
        data
        |> Map.get("action")
        |> Torngen.Client.Schema.parse({:ref, Torngen.Client.Schema.FactionOcHistoryActionEnum})
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

  defp validate_key?(:user, value) do
    Torngen.Client.Schema.validate?(
      value,
      {:one_of, [static: :null, ref: Torngen.Client.Schema.BasicUser]}
    )
  end

  defp validate_key?(:timestamp, value) do
    Torngen.Client.Schema.validate?(value, {:static, :integer})
  end

  defp validate_key?(:text, value) do
    Torngen.Client.Schema.validate?(value, {:static, :string})
  end

  defp validate_key?(:performed_by, value) do
    Torngen.Client.Schema.validate?(
      value,
      {:one_of, [static: :null, ref: Torngen.Client.Schema.BasicUser]}
    )
  end

  defp validate_key?(:id, value) do
    Torngen.Client.Schema.validate?(value, {:static, :integer})
  end

  defp validate_key?(:details, value) do
    Torngen.Client.Schema.validate?(
      value,
      {:one_of,
       [
         static: :null,
         ref: Torngen.Client.Schema.FactionOcHistoryPayoutReceivedDetails,
         ref: Torngen.Client.Schema.FactionOcHistoryPayoutDetails,
         ref: Torngen.Client.Schema.FactionOcHistoryInjuryDetails,
         ref: Torngen.Client.Schema.FactionOcHistoryPunishmentDetails,
         ref: Torngen.Client.Schema.FactionOcHistoryItem,
         ref: Torngen.Client.Schema.FactionOcHistorySpawnDetails,
         ref: Torngen.Client.Schema.FactionOcHistoryRoleChangeDetails,
         ref: Torngen.Client.Schema.FactionOcHistoryRoleDetails
       ]}
    )
  end

  defp validate_key?(:action, value) do
    Torngen.Client.Schema.validate?(
      value,
      {:ref, Torngen.Client.Schema.FactionOcHistoryActionEnum}
    )
  end

  @spec keys() :: list(atom())
  def keys(), do: @keys
end
