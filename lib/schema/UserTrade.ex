defmodule Torngen.Client.Schema.UserTrade do
  @moduledoc false

  use Torngen.Client.SchemaObjectAccess, deprecated: []

  @behaviour Torngen.Client.Schema

  @keys [:user, :trader, :timestamp, :id]

  defstruct [
    :user,
    :trader,
    :timestamp,
    :id
  ]

  @type t :: %__MODULE__{
          user: Torngen.Client.Schema.UserTradeParticipant.t(),
          trader: Torngen.Client.Schema.UserTradeParticipant.t(),
          timestamp: integer(),
          id: Torngen.Client.Schema.TradeId.t()
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
      timestamp: data |> Map.get("timestamp") |> Torngen.Client.Schema.parse({:static, :integer}),
      id:
        data
        |> Map.get("id")
        |> Torngen.Client.Schema.parse({:ref, Torngen.Client.Schema.TradeId})
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

  defp validate_key?(:id, value) do
    Torngen.Client.Schema.validate?(value, {:ref, Torngen.Client.Schema.TradeId})
  end

  @spec keys() :: list(atom())
  def keys(), do: @keys
end
