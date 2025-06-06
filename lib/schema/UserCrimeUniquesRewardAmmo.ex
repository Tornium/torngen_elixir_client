defmodule Torngen.Client.Schema.UserCrimeUniquesRewardAmmo do
  @moduledoc false

  use Torngen.Client.SchemaObjectAccess, deprecated: []

  @behaviour Torngen.Client.Schema

  @keys [:type, :amount]

  defstruct [
    :type,
    :amount
  ]

  @type t :: %__MODULE__{
          type: Torngen.Client.Schema.UserCrimeUniquesRewardAmmoEnum.t(),
          amount: integer()
        }

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      type:
        data
        |> Map.get("type")
        |> Torngen.Client.Schema.parse(Torngen.Client.Schema.UserCrimeUniquesRewardAmmoEnum),
      amount: data |> Map.get("amount") |> Torngen.Client.Schema.parse({:static, :integer})
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
    Torngen.Client.Schema.validate?(value, Torngen.Client.Schema.UserCrimeUniquesRewardAmmoEnum)
  end

  defp validate_key?(:amount, value) do
    Torngen.Client.Schema.validate?(value, {:static, :integer})
  end

  @spec keys() :: list(atom())
  def keys(), do: @keys
end
