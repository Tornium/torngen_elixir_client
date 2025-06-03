defmodule Torngen.Client.Schema.FactionRaidReportAttacker do
  @moduledoc false

  use Torngen.Client.SchemaObjectAccess, deprecated: []

  @behaviour Torngen.Client.Schema

  @keys [:user, :damage, :attacks]

  defstruct [
    :user,
    :damage,
    :attacks
  ]

  @type t :: %__MODULE__{
          user: Torngen.Client.Schema.FactionRaidReportUser.t(),
          damage: integer() | float(),
          attacks: integer()
        }

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      user:
        data
        |> Map.get("user")
        |> Torngen.Client.Schema.parse(Torngen.Client.Schema.FactionRaidReportUser),
      damage: data |> Map.get("damage") |> Torngen.Client.Schema.parse({:static, :number}),
      attacks: data |> Map.get("attacks") |> Torngen.Client.Schema.parse({:static, :integer})
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
    Torngen.Client.Schema.validate?(value, Torngen.Client.Schema.FactionRaidReportUser)
  end

  defp validate_key?(:damage, value) do
    Torngen.Client.Schema.validate?(value, {:static, :number})
  end

  defp validate_key?(:attacks, value) do
    Torngen.Client.Schema.validate?(value, {:static, :integer})
  end

  @spec keys() :: list(atom())
  def keys(), do: @keys
end
