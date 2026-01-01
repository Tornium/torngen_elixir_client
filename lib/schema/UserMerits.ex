defmodule Torngen.Client.Schema.UserMerits do
  @moduledoc false

  use Torngen.Client.SchemaObjectAccess, deprecated: []

  @behaviour Torngen.Client.Schema

  @keys [:used, :upgrades, :medals, :honors, :available]

  defstruct [
    :used,
    :upgrades,
    :medals,
    :honors,
    :available
  ]

  @type t :: %__MODULE__{
          used: integer(),
          upgrades: [Torngen.Client.Schema.UserMeritUpgrade.t()],
          medals: integer(),
          honors: integer(),
          available: integer()
        }

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      used: data |> Map.get("used") |> Torngen.Client.Schema.parse({:static, :integer}),
      upgrades:
        data
        |> Map.get("upgrades")
        |> Torngen.Client.Schema.parse({:array, {:ref, Torngen.Client.Schema.UserMeritUpgrade}}),
      medals: data |> Map.get("medals") |> Torngen.Client.Schema.parse({:static, :integer}),
      honors: data |> Map.get("honors") |> Torngen.Client.Schema.parse({:static, :integer}),
      available: data |> Map.get("available") |> Torngen.Client.Schema.parse({:static, :integer})
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

  defp validate_key?(:used, value) do
    Torngen.Client.Schema.validate?(value, {:static, :integer})
  end

  defp validate_key?(:upgrades, value) do
    Torngen.Client.Schema.validate?(
      value,
      {:array, {:ref, Torngen.Client.Schema.UserMeritUpgrade}}
    )
  end

  defp validate_key?(:medals, value) do
    Torngen.Client.Schema.validate?(value, {:static, :integer})
  end

  defp validate_key?(:honors, value) do
    Torngen.Client.Schema.validate?(value, {:static, :integer})
  end

  defp validate_key?(:available, value) do
    Torngen.Client.Schema.validate?(value, {:static, :integer})
  end

  @spec keys() :: list(atom())
  def keys(), do: @keys
end
