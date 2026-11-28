defmodule Torngen.Client.Schema.FactionOcHistoryPunishmentDetails do
  @moduledoc false

  use Torngen.Client.SchemaObjectAccess, deprecated: []

  @behaviour Torngen.Client.Schema

  @keys [:reason, :duration]

  defstruct [
    :reason,
    :duration
  ]

  @type t :: %__MODULE__{
          reason: nil | String.t(),
          duration: integer()
        }

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      reason:
        data
        |> Map.get("reason")
        |> Torngen.Client.Schema.parse({:one_of, [static: :null, static: :string]}),
      duration: data |> Map.get("duration") |> Torngen.Client.Schema.parse({:static, :integer})
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

  defp validate_key?(:reason, value) do
    Torngen.Client.Schema.validate?(value, {:one_of, [static: :null, static: :string]})
  end

  defp validate_key?(:duration, value) do
    Torngen.Client.Schema.validate?(value, {:static, :integer})
  end

  @spec keys() :: list(atom())
  def keys(), do: @keys
end
