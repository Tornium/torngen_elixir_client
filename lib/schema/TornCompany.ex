defmodule Torngen.Client.Schema.TornCompany do
  @moduledoc false

  use Torngen.Client.SchemaObjectAccess, deprecated: []

  @behaviour Torngen.Client.Schema

  @keys [:stock, :specials, :positions, :name, :id, :employees, :cost]

  defstruct [
    :stock,
    :specials,
    :positions,
    :name,
    :id,
    :employees,
    :cost
  ]

  @type t :: %__MODULE__{
          stock: [Torngen.Client.Schema.TornCompanyStock.t()],
          specials: [Torngen.Client.Schema.TornCompanySpecial.t()],
          positions: [Torngen.Client.Schema.TornCompanyPosition.t()],
          name: String.t(),
          id: Torngen.Client.Schema.CompanyTypeId.t(),
          employees: integer(),
          cost: integer()
        }

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      stock:
        data
        |> Map.get("stock")
        |> Torngen.Client.Schema.parse({:array, {:ref, Torngen.Client.Schema.TornCompanyStock}}),
      specials:
        data
        |> Map.get("specials")
        |> Torngen.Client.Schema.parse({:array, {:ref, Torngen.Client.Schema.TornCompanySpecial}}),
      positions:
        data
        |> Map.get("positions")
        |> Torngen.Client.Schema.parse(
          {:array, {:ref, Torngen.Client.Schema.TornCompanyPosition}}
        ),
      name: data |> Map.get("name") |> Torngen.Client.Schema.parse({:static, :string}),
      id:
        data
        |> Map.get("id")
        |> Torngen.Client.Schema.parse({:ref, Torngen.Client.Schema.CompanyTypeId}),
      employees: data |> Map.get("employees") |> Torngen.Client.Schema.parse({:static, :integer}),
      cost: data |> Map.get("cost") |> Torngen.Client.Schema.parse({:static, :integer})
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

  defp validate_key?(:stock, value) do
    Torngen.Client.Schema.validate?(
      value,
      {:array, {:ref, Torngen.Client.Schema.TornCompanyStock}}
    )
  end

  defp validate_key?(:specials, value) do
    Torngen.Client.Schema.validate?(
      value,
      {:array, {:ref, Torngen.Client.Schema.TornCompanySpecial}}
    )
  end

  defp validate_key?(:positions, value) do
    Torngen.Client.Schema.validate?(
      value,
      {:array, {:ref, Torngen.Client.Schema.TornCompanyPosition}}
    )
  end

  defp validate_key?(:name, value) do
    Torngen.Client.Schema.validate?(value, {:static, :string})
  end

  defp validate_key?(:id, value) do
    Torngen.Client.Schema.validate?(value, {:ref, Torngen.Client.Schema.CompanyTypeId})
  end

  defp validate_key?(:employees, value) do
    Torngen.Client.Schema.validate?(value, {:static, :integer})
  end

  defp validate_key?(:cost, value) do
    Torngen.Client.Schema.validate?(value, {:static, :integer})
  end

  @spec keys() :: list(atom())
  def keys(), do: @keys
end
