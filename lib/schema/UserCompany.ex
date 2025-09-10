defmodule Torngen.Client.Schema.UserCompany do
  @moduledoc false

  use Torngen.Client.SchemaObjectAccess, deprecated: []

  @behaviour Torngen.Client.Schema

  @keys [:type_id, :type, :rating, :position, :name, :id, :days_in_company]

  defstruct [
    :type_id,
    :type,
    :rating,
    :position,
    :name,
    :id,
    :days_in_company
  ]

  @type t :: %__MODULE__{
          type_id: Torngen.Client.Schema.CompanyTypeId.t(),
          type: String.t(),
          rating: integer(),
          position: String.t(),
          name: String.t(),
          id: Torngen.Client.Schema.CompanyId.t(),
          days_in_company: integer()
        }

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      type_id:
        data
        |> Map.get("type_id")
        |> Torngen.Client.Schema.parse(Torngen.Client.Schema.CompanyTypeId),
      type: data |> Map.get("type") |> Torngen.Client.Schema.parse({:enum, :string, ["company"]}),
      rating: data |> Map.get("rating") |> Torngen.Client.Schema.parse({:static, :integer}),
      position: data |> Map.get("position") |> Torngen.Client.Schema.parse({:static, :string}),
      name: data |> Map.get("name") |> Torngen.Client.Schema.parse({:static, :string}),
      id: data |> Map.get("id") |> Torngen.Client.Schema.parse(Torngen.Client.Schema.CompanyId),
      days_in_company:
        data |> Map.get("days_in_company") |> Torngen.Client.Schema.parse({:static, :integer})
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

  defp validate_key?(:type_id, value) do
    Torngen.Client.Schema.validate?(value, Torngen.Client.Schema.CompanyTypeId)
  end

  defp validate_key?(:type, value) do
    Torngen.Client.Schema.validate?(value, {:enum, :string, ["company"]})
  end

  defp validate_key?(:rating, value) do
    Torngen.Client.Schema.validate?(value, {:static, :integer})
  end

  defp validate_key?(:position, value) do
    Torngen.Client.Schema.validate?(value, {:static, :string})
  end

  defp validate_key?(:name, value) do
    Torngen.Client.Schema.validate?(value, {:static, :string})
  end

  defp validate_key?(:id, value) do
    Torngen.Client.Schema.validate?(value, Torngen.Client.Schema.CompanyId)
  end

  defp validate_key?(:days_in_company, value) do
    Torngen.Client.Schema.validate?(value, {:static, :integer})
  end

  @spec keys() :: list(atom())
  def keys(), do: @keys
end
