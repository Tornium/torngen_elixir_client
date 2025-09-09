defmodule Torngen.Client.Schema.UserCompetitionHalloween do
  @moduledoc false

  use Torngen.Client.SchemaObjectAccess, deprecated: []

  @behaviour Torngen.Client.Schema

  @keys [:treats_collected, :name, :basket]

  defstruct [
    :treats_collected,
    :name,
    :basket
  ]

  @type t :: %__MODULE__{
          treats_collected: integer(),
          name: String.t(),
          basket: %{:name => String.t(), :id => Torngen.Client.Schema.ItemId.t()}
        }

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      treats_collected:
        data |> Map.get("treats_collected") |> Torngen.Client.Schema.parse({:static, :integer}),
      name:
        data |> Map.get("name") |> Torngen.Client.Schema.parse({:enum, :string, ["Halloween"]}),
      basket:
        data
        |> Map.get("basket")
        |> Torngen.Client.Schema.parse(
          {:object, %{id: Torngen.Client.Schema.ItemId, name: {:static, :string}}}
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

  defp validate_key?(:treats_collected, value) do
    Torngen.Client.Schema.validate?(value, {:static, :integer})
  end

  defp validate_key?(:name, value) do
    Torngen.Client.Schema.validate?(value, {:enum, :string, ["Halloween"]})
  end

  defp validate_key?(:basket, value) do
    Torngen.Client.Schema.validate?(
      value,
      {:object, %{id: Torngen.Client.Schema.ItemId, name: {:static, :string}}}
    )
  end

  @spec keys() :: list(atom())
  def keys(), do: @keys
end
