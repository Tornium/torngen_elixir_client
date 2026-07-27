defmodule Torngen.Client.Schema.UserTrade do
  @moduledoc false

  use Torngen.Client.SchemaObjectAccess, deprecated: [:timestamp]

  @behaviour Torngen.Client.Schema

  @keys [:user, :trader, :timestamp, :modified_at, :id, :expires_at, :completed_at]

  defstruct [
    :user,
    :trader,
    :timestamp,
    :modified_at,
    :id,
    :expires_at,
    :completed_at
  ]

  @type t :: %__MODULE__{
          user: Torngen.Client.Schema.UserTradeParticipant.t(),
          trader: Torngen.Client.Schema.UserTradeParticipant.t(),
          timestamp: nil | integer(),
          modified_at: nil | integer(),
          id: Torngen.Client.Schema.TradeId.t(),
          expires_at: nil | integer(),
          completed_at: nil | integer()
        }

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      user:
        data
        |> Map.get("user")
        |> Torngen.Client.Schema.parse({:ref, Torngen.Client.Schema.UserTradeParticipant}),
      trader:
        data
        |> Map.get("trader")
        |> Torngen.Client.Schema.parse({:ref, Torngen.Client.Schema.UserTradeParticipant}),
      timestamp:
        data |> Map.get("timestamp") |> Torngen.Client.Schema.parse({:one_of, [static: :integer]}),
      modified_at:
        data
        |> Map.get("modified_at")
        |> Torngen.Client.Schema.parse({:one_of, [static: :null, static: :integer]}),
      id:
        data
        |> Map.get("id")
        |> Torngen.Client.Schema.parse({:ref, Torngen.Client.Schema.TradeId}),
      expires_at:
        data
        |> Map.get("expires_at")
        |> Torngen.Client.Schema.parse({:one_of, [static: :null, static: :integer]}),
      completed_at:
        data
        |> Map.get("completed_at")
        |> Torngen.Client.Schema.parse({:one_of, [static: :null, static: :integer]})
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
    Torngen.Client.Schema.validate?(value, {:ref, Torngen.Client.Schema.UserTradeParticipant})
  end

  defp validate_key?(:trader, value) do
    Torngen.Client.Schema.validate?(value, {:ref, Torngen.Client.Schema.UserTradeParticipant})
  end

  defp validate_key?(:timestamp, value) do
    Torngen.Client.Schema.validate?(value, {:static, :integer})
  end

  defp validate_key?(:modified_at, value) do
    Torngen.Client.Schema.validate?(value, {:one_of, [static: :null, static: :integer]})
  end

  defp validate_key?(:id, value) do
    Torngen.Client.Schema.validate?(value, {:ref, Torngen.Client.Schema.TradeId})
  end

  defp validate_key?(:expires_at, value) do
    Torngen.Client.Schema.validate?(value, {:one_of, [static: :null, static: :integer]})
  end

  defp validate_key?(:completed_at, value) do
    Torngen.Client.Schema.validate?(value, {:one_of, [static: :null, static: :integer]})
  end

  @spec keys() :: list(atom())
  def keys(), do: @keys
end
