defmodule Torngen.Client.Schema.UserVirusResponse do
  @moduledoc false

  use Torngen.Client.SchemaObjectAccess, deprecated: []

  @behaviour Torngen.Client.Schema

  @keys [:virus]

  defstruct [
    :virus
  ]

  @type t :: %__MODULE__{
          virus: nil | Torngen.Client.Schema.UserVirus.t()
        }

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      virus:
        data
        |> Map.get("virus")
        |> Torngen.Client.Schema.parse(
          {:one_of, [static: :null, ref: Torngen.Client.Schema.UserVirus]}
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

  defp validate_key?(:virus, value) do
    Torngen.Client.Schema.validate?(
      value,
      {:one_of, [static: :null, ref: Torngen.Client.Schema.UserVirus]}
    )
  end

  @spec keys() :: list(atom())
  def keys(), do: @keys
end
