defmodule Torngen.Client.Schema.CompanyEmployeesResponse do
  @moduledoc false

  use Torngen.Client.SchemaObjectAccess, deprecated: []

  @behaviour Torngen.Client.Schema

  @keys [:employees]

  defstruct [
    :employees
  ]

  @type t :: %__MODULE__{
          employees: [
            Torngen.Client.Schema.CompanyEmployeeFull.t()
            | Torngen.Client.Schema.CompanyEmployeeExtended.t()
            | Torngen.Client.Schema.CompanyEmployee.t()
          ]
        }

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      employees:
        data
        |> Map.get("employees")
        |> Torngen.Client.Schema.parse(
          {:array,
           {:one_of,
            [
              ref: Torngen.Client.Schema.CompanyEmployeeFull,
              ref: Torngen.Client.Schema.CompanyEmployeeExtended,
              ref: Torngen.Client.Schema.CompanyEmployee
            ]}}
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

  defp validate_key?(:employees, value) do
    Torngen.Client.Schema.validate?(
      value,
      {:array,
       {:one_of,
        [
          ref: Torngen.Client.Schema.CompanyEmployeeFull,
          ref: Torngen.Client.Schema.CompanyEmployeeExtended,
          ref: Torngen.Client.Schema.CompanyEmployee
        ]}}
    )
  end

  @spec keys() :: list(atom())
  def keys(), do: @keys
end
