defmodule Torngen.Client.Schema.CompaniesResponse do
  @moduledoc false

  use Torngen.Client.SchemaObjectAccess, deprecated: []

  @behaviour Torngen.Client.Schema

  @keys [:companies_timestamp, :companies_delay, :companies, :_metadata]

  defstruct [
    :companies_timestamp,
    :companies_delay,
    :companies,
    :_metadata
  ]

  @type t :: %__MODULE__{
          companies_timestamp: integer(),
          companies_delay: integer(),
          companies: [Torngen.Client.Schema.CompanyProfile.t()],
          _metadata: Torngen.Client.Schema.RequestMetadataWithLinksAndTotal.t()
        }

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      companies_timestamp:
        data |> Map.get("companies_timestamp") |> Torngen.Client.Schema.parse({:static, :integer}),
      companies_delay:
        data |> Map.get("companies_delay") |> Torngen.Client.Schema.parse({:static, :integer}),
      companies:
        data
        |> Map.get("companies")
        |> Torngen.Client.Schema.parse({:array, {:ref, Torngen.Client.Schema.CompanyProfile}}),
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

  defp validate_key?(:companies_timestamp, value) do
    Torngen.Client.Schema.validate?(value, {:static, :integer})
  end

  defp validate_key?(:companies_delay, value) do
    Torngen.Client.Schema.validate?(value, {:static, :integer})
  end

  defp validate_key?(:companies, value) do
    Torngen.Client.Schema.validate?(value, {:array, {:ref, Torngen.Client.Schema.CompanyProfile}})
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
