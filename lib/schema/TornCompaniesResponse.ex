defmodule Torngen.Client.Schema.TornCompaniesResponse do
  @moduledoc false

  use Torngen.Client.SchemaObjectAccess, deprecated: []

  @behaviour Torngen.Client.Schema

  @keys [:companies]

  defstruct [
    :companies
  ]

  @type t :: %__MODULE__{
          companies: [Torngen.Client.Schema.TornCompany.t()]
        }

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      companies:
        data
        |> Map.get("companies")
        |> Torngen.Client.Schema.parse({:array, {:ref, Torngen.Client.Schema.TornCompany}})
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

  defp validate_key?(:companies, value) do
    Torngen.Client.Schema.validate?(value, {:array, {:ref, Torngen.Client.Schema.TornCompany}})
  end

  @spec keys() :: list(atom())
  def keys(), do: @keys
end
