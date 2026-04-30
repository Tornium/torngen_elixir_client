defmodule Torngen.Client.Schema.CompanyApplication do
  @moduledoc false

  use Torngen.Client.SchemaObjectAccess, deprecated: []

  @behaviour Torngen.Client.Schema

  @keys [:status, :player, :message, :expires_at]

  defstruct [
    :status,
    :player,
    :message,
    :expires_at
  ]

  @type t :: %__MODULE__{
          status: Torngen.Client.Schema.ApplicationStatusEnum.t(),
          player: Torngen.Client.Schema.CompanyApplicationPlayer.t(),
          message: nil | String.t(),
          expires_at: integer()
        }

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      status:
        data
        |> Map.get("status")
        |> Torngen.Client.Schema.parse({:ref, Torngen.Client.Schema.ApplicationStatusEnum}),
      player:
        data
        |> Map.get("player")
        |> Torngen.Client.Schema.parse({:ref, Torngen.Client.Schema.CompanyApplicationPlayer}),
      message:
        data
        |> Map.get("message")
        |> Torngen.Client.Schema.parse({:one_of, [static: :null, static: :string]}),
      expires_at:
        data |> Map.get("expires_at") |> Torngen.Client.Schema.parse({:static, :integer})
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

  defp validate_key?(:status, value) do
    Torngen.Client.Schema.validate?(value, {:ref, Torngen.Client.Schema.ApplicationStatusEnum})
  end

  defp validate_key?(:player, value) do
    Torngen.Client.Schema.validate?(value, {:ref, Torngen.Client.Schema.CompanyApplicationPlayer})
  end

  defp validate_key?(:message, value) do
    Torngen.Client.Schema.validate?(value, {:one_of, [static: :null, static: :string]})
  end

  defp validate_key?(:expires_at, value) do
    Torngen.Client.Schema.validate?(value, {:static, :integer})
  end

  @spec keys() :: list(atom())
  def keys(), do: @keys
end
