defmodule Torngen.Client.Schema.UserMessage do
  @moduledoc false

  use Torngen.Client.SchemaObjectAccess, deprecated: []

  @behaviour Torngen.Client.Schema

  @keys [:type, :topic, :timestamp, :sender, :seen, :read, :id]

  defstruct [
    :type,
    :topic,
    :timestamp,
    :sender,
    :seen,
    :read,
    :id
  ]

  @type t :: %__MODULE__{
          type: Torngen.Client.Schema.UserMessageTypeEnum.t(),
          topic: String.t(),
          timestamp: integer(),
          sender: Torngen.Client.Schema.BasicUser.t(),
          seen: boolean(),
          read: boolean(),
          id: Torngen.Client.Schema.UserMessageId.t()
        }

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      type:
        data
        |> Map.get("type")
        |> Torngen.Client.Schema.parse(Torngen.Client.Schema.UserMessageTypeEnum),
      topic: data |> Map.get("topic") |> Torngen.Client.Schema.parse({:static, :string}),
      timestamp: data |> Map.get("timestamp") |> Torngen.Client.Schema.parse({:static, :integer}),
      sender:
        data |> Map.get("sender") |> Torngen.Client.Schema.parse(Torngen.Client.Schema.BasicUser),
      seen: data |> Map.get("seen") |> Torngen.Client.Schema.parse({:static, :boolean}),
      read: data |> Map.get("read") |> Torngen.Client.Schema.parse({:static, :boolean}),
      id:
        data |> Map.get("id") |> Torngen.Client.Schema.parse(Torngen.Client.Schema.UserMessageId)
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

  defp validate_key?(:type, value) do
    Torngen.Client.Schema.validate?(value, Torngen.Client.Schema.UserMessageTypeEnum)
  end

  defp validate_key?(:topic, value) do
    Torngen.Client.Schema.validate?(value, {:static, :string})
  end

  defp validate_key?(:timestamp, value) do
    Torngen.Client.Schema.validate?(value, {:static, :integer})
  end

  defp validate_key?(:sender, value) do
    Torngen.Client.Schema.validate?(value, Torngen.Client.Schema.BasicUser)
  end

  defp validate_key?(:seen, value) do
    Torngen.Client.Schema.validate?(value, {:static, :boolean})
  end

  defp validate_key?(:read, value) do
    Torngen.Client.Schema.validate?(value, {:static, :boolean})
  end

  defp validate_key?(:id, value) do
    Torngen.Client.Schema.validate?(value, Torngen.Client.Schema.UserMessageId)
  end

  @spec keys() :: list(atom())
  def keys(), do: @keys
end
