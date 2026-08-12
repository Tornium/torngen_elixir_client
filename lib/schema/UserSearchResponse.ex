defmodule Torngen.Client.Schema.UserSearchResponse do
  @moduledoc false

  use Torngen.Client.SchemaObjectAccess, deprecated: []

  @behaviour Torngen.Client.Schema

  @keys [:search, :_metadata]

  defstruct [
    :search,
    :_metadata
  ]

  @type t :: %__MODULE__{
          search: [Torngen.Client.Schema.UserSearch.t()],
          _metadata: Torngen.Client.Schema.RequestMetadataWithLinksAndTotal.t()
        }

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      search:
        data
        |> Map.get("search")
        |> Torngen.Client.Schema.parse({:array, {:ref, Torngen.Client.Schema.UserSearch}}),
      _metadata:
        data
        |> Map.get("_metadata")
        |> Torngen.Client.Schema.parse(
          {:ref, Torngen.Client.Schema.RequestMetadataWithLinksAndTotal}
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

  defp validate_key?(:search, value) do
    Torngen.Client.Schema.validate?(value, {:array, {:ref, Torngen.Client.Schema.UserSearch}})
  end

  defp validate_key?(:_metadata, value) do
    Torngen.Client.Schema.validate?(
      value,
      {:ref, Torngen.Client.Schema.RequestMetadataWithLinksAndTotal}
    )
  end

  @spec keys() :: list(atom())
  def keys(), do: @keys
end
