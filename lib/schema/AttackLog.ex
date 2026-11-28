defmodule Torngen.Client.Schema.AttackLog do
  @moduledoc false

  use Torngen.Client.SchemaObjectAccess, deprecated: []

  @behaviour Torngen.Client.Schema

  @keys [:timestamp, :text, :icon, :defender, :attacker_item, :attacker, :action]

  defstruct [
    :timestamp,
    :text,
    :icon,
    :defender,
    :attacker_item,
    :attacker,
    :action
  ]

  @type t :: %__MODULE__{
          timestamp: integer(),
          text: String.t(),
          icon: String.t(),
          defender: nil | Torngen.Client.Schema.AttackLogDefender.t(),
          attacker_item: nil | nil | Torngen.Client.Schema.AttackLogItem.t(),
          attacker: nil | Torngen.Client.Schema.AttackLogAttacker.t(),
          action: Torngen.Client.Schema.AttackActionEnum.t()
        }

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      timestamp: data |> Map.get("timestamp") |> Torngen.Client.Schema.parse({:static, :integer}),
      text: data |> Map.get("text") |> Torngen.Client.Schema.parse({:static, :string}),
      icon: data |> Map.get("icon") |> Torngen.Client.Schema.parse({:static, :string}),
      defender:
        data
        |> Map.get("defender")
        |> Torngen.Client.Schema.parse(
          {:one_of, [static: :null, ref: Torngen.Client.Schema.AttackLogDefender]}
        ),
      attacker_item:
        data
        |> Map.get("attacker_item")
        |> Torngen.Client.Schema.parse(
          {:one_of,
           [static: :null, one_of: [static: :null, ref: Torngen.Client.Schema.AttackLogItem]]}
        ),
      attacker:
        data
        |> Map.get("attacker")
        |> Torngen.Client.Schema.parse(
          {:one_of, [static: :null, ref: Torngen.Client.Schema.AttackLogAttacker]}
        ),
      action:
        data
        |> Map.get("action")
        |> Torngen.Client.Schema.parse({:ref, Torngen.Client.Schema.AttackActionEnum})
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

  defp validate_key?(:timestamp, value) do
    Torngen.Client.Schema.validate?(value, {:static, :integer})
  end

  defp validate_key?(:text, value) do
    Torngen.Client.Schema.validate?(value, {:static, :string})
  end

  defp validate_key?(:icon, value) do
    Torngen.Client.Schema.validate?(value, {:static, :string})
  end

  defp validate_key?(:defender, value) do
    Torngen.Client.Schema.validate?(
      value,
      {:one_of, [static: :null, ref: Torngen.Client.Schema.AttackLogDefender]}
    )
  end

  defp validate_key?(:attacker_item, value) do
    Torngen.Client.Schema.validate?(
      value,
      {:one_of, [static: :null, ref: Torngen.Client.Schema.AttackLogItem]}
    )
  end

  defp validate_key?(:attacker, value) do
    Torngen.Client.Schema.validate?(
      value,
      {:one_of, [static: :null, ref: Torngen.Client.Schema.AttackLogAttacker]}
    )
  end

  defp validate_key?(:action, value) do
    Torngen.Client.Schema.validate?(value, {:ref, Torngen.Client.Schema.AttackActionEnum})
  end

  @spec keys() :: list(atom())
  def keys(), do: @keys
end
