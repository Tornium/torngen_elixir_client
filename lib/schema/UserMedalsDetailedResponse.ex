defmodule Torngen.Client.Schema.UserMedalsDetailedResponse do
  @moduledoc false

  use Torngen.Client.SchemaObjectAccess, deprecated: []

  @behaviour Torngen.Client.Schema

  @keys [:medals]

  defstruct [
    :medals
  ]

  @type t :: %__MODULE__{
          medals: [Torngen.Client.Schema.UserMedalDetailed.t()]
        }

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      medals:
        data
        |> Map.get("medals")
        |> Torngen.Client.Schema.parse({:array, {:ref, Torngen.Client.Schema.UserMedalDetailed}})
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

  defp validate_key?(:medals, value) do
    Torngen.Client.Schema.validate?(
      value,
      {:array, {:ref, Torngen.Client.Schema.UserMedalDetailed}}
    )
  end

  @spec keys() :: list(atom())
  def keys(), do: @keys
end
