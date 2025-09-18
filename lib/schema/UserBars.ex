defmodule Torngen.Client.Schema.UserBars do
  @moduledoc false

  use Torngen.Client.SchemaObjectAccess, deprecated: []

  @behaviour Torngen.Client.Schema

  @keys [:nerve, :life, :happy, :energy, :chain]

  defstruct [
    :nerve,
    :life,
    :happy,
    :energy,
    :chain
  ]

  @type t :: %__MODULE__{
          nerve: Torngen.Client.Schema.UserBar.t(),
          life: Torngen.Client.Schema.UserBar.t(),
          happy: Torngen.Client.Schema.UserBar.t(),
          energy: Torngen.Client.Schema.UserBar.t(),
          chain: nil | Torngen.Client.Schema.FactionOngoingChain.t()
        }

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      nerve:
        data |> Map.get("nerve") |> Torngen.Client.Schema.parse(Torngen.Client.Schema.UserBar),
      life: data |> Map.get("life") |> Torngen.Client.Schema.parse(Torngen.Client.Schema.UserBar),
      happy:
        data |> Map.get("happy") |> Torngen.Client.Schema.parse(Torngen.Client.Schema.UserBar),
      energy:
        data |> Map.get("energy") |> Torngen.Client.Schema.parse(Torngen.Client.Schema.UserBar),
      chain:
        data
        |> Map.get("chain")
        |> Torngen.Client.Schema.parse(
          {:one_of, [{:static, :null}, Torngen.Client.Schema.FactionOngoingChain]}
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

  defp validate_key?(:nerve, value) do
    Torngen.Client.Schema.validate?(value, Torngen.Client.Schema.UserBar)
  end

  defp validate_key?(:life, value) do
    Torngen.Client.Schema.validate?(value, Torngen.Client.Schema.UserBar)
  end

  defp validate_key?(:happy, value) do
    Torngen.Client.Schema.validate?(value, Torngen.Client.Schema.UserBar)
  end

  defp validate_key?(:energy, value) do
    Torngen.Client.Schema.validate?(value, Torngen.Client.Schema.UserBar)
  end

  defp validate_key?(:chain, value) do
    Torngen.Client.Schema.validate?(
      value,
      {:one_of, [{:static, :null}, Torngen.Client.Schema.FactionOngoingChain]}
    )
  end

  @spec keys() :: list(atom())
  def keys(), do: @keys
end
