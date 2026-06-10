defmodule Torngen.Client.Schema.CompanyProfile do
  @moduledoc false

  use Torngen.Client.SchemaObjectAccess, deprecated: []

  @behaviour Torngen.Client.Schema

  @keys [
    :type,
    :rating,
    :name,
    :income,
    :image,
    :id,
    :employees,
    :director,
    :days_old,
    :customers,
    :created_at,
    :applications_allowed
  ]

  defstruct [
    :type,
    :rating,
    :name,
    :income,
    :image,
    :id,
    :employees,
    :director,
    :days_old,
    :customers,
    :created_at,
    :applications_allowed
  ]

  @type t :: %__MODULE__{
          type: Torngen.Client.Schema.CompanyType.t(),
          rating: integer(),
          name: String.t(),
          income: Torngen.Client.Schema.CompanyIncome.t(),
          image: nil | String.t(),
          id: Torngen.Client.Schema.CompanyId.t(),
          employees: Torngen.Client.Schema.CompanyEmployees.t(),
          director: Torngen.Client.Schema.CompanyDirector.t(),
          days_old: integer(),
          customers: Torngen.Client.Schema.CompanyCustomers.t(),
          created_at: integer(),
          applications_allowed: boolean()
        }

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      type:
        data
        |> Map.get("type")
        |> Torngen.Client.Schema.parse({:ref, Torngen.Client.Schema.CompanyType}),
      rating: data |> Map.get("rating") |> Torngen.Client.Schema.parse({:static, :integer}),
      name: data |> Map.get("name") |> Torngen.Client.Schema.parse({:static, :string}),
      income:
        data
        |> Map.get("income")
        |> Torngen.Client.Schema.parse({:ref, Torngen.Client.Schema.CompanyIncome}),
      image:
        data
        |> Map.get("image")
        |> Torngen.Client.Schema.parse({:one_of, [static: :null, static: :string]}),
      id:
        data
        |> Map.get("id")
        |> Torngen.Client.Schema.parse({:ref, Torngen.Client.Schema.CompanyId}),
      employees:
        data
        |> Map.get("employees")
        |> Torngen.Client.Schema.parse({:ref, Torngen.Client.Schema.CompanyEmployees}),
      director:
        data
        |> Map.get("director")
        |> Torngen.Client.Schema.parse({:ref, Torngen.Client.Schema.CompanyDirector}),
      days_old: data |> Map.get("days_old") |> Torngen.Client.Schema.parse({:static, :integer}),
      customers:
        data
        |> Map.get("customers")
        |> Torngen.Client.Schema.parse({:ref, Torngen.Client.Schema.CompanyCustomers}),
      created_at:
        data |> Map.get("created_at") |> Torngen.Client.Schema.parse({:static, :integer}),
      applications_allowed:
        data
        |> Map.get("applications_allowed")
        |> Torngen.Client.Schema.parse({:static, :boolean})
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
    Torngen.Client.Schema.validate?(value, {:ref, Torngen.Client.Schema.CompanyType})
  end

  defp validate_key?(:rating, value) do
    Torngen.Client.Schema.validate?(value, {:static, :integer})
  end

  defp validate_key?(:name, value) do
    Torngen.Client.Schema.validate?(value, {:static, :string})
  end

  defp validate_key?(:income, value) do
    Torngen.Client.Schema.validate?(value, {:ref, Torngen.Client.Schema.CompanyIncome})
  end

  defp validate_key?(:image, value) do
    Torngen.Client.Schema.validate?(value, {:one_of, [static: :null, static: :string]})
  end

  defp validate_key?(:id, value) do
    Torngen.Client.Schema.validate?(value, {:ref, Torngen.Client.Schema.CompanyId})
  end

  defp validate_key?(:employees, value) do
    Torngen.Client.Schema.validate?(value, {:ref, Torngen.Client.Schema.CompanyEmployees})
  end

  defp validate_key?(:director, value) do
    Torngen.Client.Schema.validate?(value, {:ref, Torngen.Client.Schema.CompanyDirector})
  end

  defp validate_key?(:days_old, value) do
    Torngen.Client.Schema.validate?(value, {:static, :integer})
  end

  defp validate_key?(:customers, value) do
    Torngen.Client.Schema.validate?(value, {:ref, Torngen.Client.Schema.CompanyCustomers})
  end

  defp validate_key?(:created_at, value) do
    Torngen.Client.Schema.validate?(value, {:static, :integer})
  end

  defp validate_key?(:applications_allowed, value) do
    Torngen.Client.Schema.validate?(value, {:static, :boolean})
  end

  @spec keys() :: list(atom())
  def keys(), do: @keys
end
