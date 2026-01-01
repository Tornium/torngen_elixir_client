defmodule Torngen.Client.Schema.UserPropertiesResponse do
  @moduledoc false

  use Torngen.Client.SchemaObjectAccess, deprecated: []

  @behaviour Torngen.Client.Schema

  @keys [:properties, :_metadata]

  defstruct [
    :properties,
    :_metadata
  ]

  @type t :: %__MODULE__{
          properties: [
            Torngen.Client.Schema.UserPropertyDetailsExtendedForSale.t()
            | Torngen.Client.Schema.UserPropertyDetailsExtendedForRent.t()
            | Torngen.Client.Schema.UserPropertyDetailsExtendedRented.t()
            | Torngen.Client.Schema.UserPropertyDetailsExtended.t()
            | Torngen.Client.Schema.UserPropertyBasicDetails.t()
          ],
          _metadata: Torngen.Client.Schema.RequestMetadataWithLinks.t()
        }

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      properties:
        data
        |> Map.get("properties")
        |> Torngen.Client.Schema.parse(
          {:array,
           {:one_of,
            [
              ref: Torngen.Client.Schema.UserPropertyDetailsExtendedForSale,
              ref: Torngen.Client.Schema.UserPropertyDetailsExtendedForRent,
              ref: Torngen.Client.Schema.UserPropertyDetailsExtendedRented,
              ref: Torngen.Client.Schema.UserPropertyDetailsExtended,
              ref: Torngen.Client.Schema.UserPropertyBasicDetails
            ]}}
        ),
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

  defp validate_key?(:properties, value) do
    Torngen.Client.Schema.validate?(
      value,
      {:array,
       {:one_of,
        [
          ref: Torngen.Client.Schema.UserPropertyDetailsExtendedForSale,
          ref: Torngen.Client.Schema.UserPropertyDetailsExtendedForRent,
          ref: Torngen.Client.Schema.UserPropertyDetailsExtendedRented,
          ref: Torngen.Client.Schema.UserPropertyDetailsExtended,
          ref: Torngen.Client.Schema.UserPropertyBasicDetails
        ]}}
    )
  end

  defp validate_key?(:_metadata, value) do
    Torngen.Client.Schema.validate?(value, {:ref, Torngen.Client.Schema.RequestMetadataWithLinks})
  end

  @spec keys() :: list(atom())
  def keys(), do: @keys
end
