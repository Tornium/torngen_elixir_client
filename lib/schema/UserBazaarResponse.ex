defmodule Torngen.Client.Schema.UserBazaarResponse do
  @moduledoc false

  use Torngen.Client.SchemaObjectAccess, deprecated: []

  @behaviour Torngen.Client.Schema

  @keys [:bazaar, :_metadata]

  defstruct [
    :bazaar,
    :_metadata
  ]

  @type t :: %__MODULE__{
          bazaar: Torngen.Client.Schema.UserBazaar.t(),
          _metadata: Torngen.Client.Schema.RequestMetadataWithLinks.t()
        }

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      bazaar:
        data
        |> Map.get("bazaar")
        |> Torngen.Client.Schema.parse({:ref, Torngen.Client.Schema.UserBazaar}),
      _metadata:
        data
        |> Map.get("_metadata")
        |> Torngen.Client.Schema.parse({:ref, Torngen.Client.Schema.RequestMetadataWithLinks})
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

  defp validate_key?(:bazaar, value) do
    Torngen.Client.Schema.validate?(value, {:ref, Torngen.Client.Schema.UserBazaar})
  end

  defp validate_key?(:_metadata, value) do
    Torngen.Client.Schema.validate?(value, {:ref, Torngen.Client.Schema.RequestMetadataWithLinks})
  end

  @spec keys() :: list(atom())
  def keys(), do: @keys
end
