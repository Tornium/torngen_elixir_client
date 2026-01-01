defmodule Torngen.Client.Schema.UserCompanyPoints do
  @moduledoc false

  use Torngen.Client.SchemaObjectAccess, deprecated: []

  @behaviour Torngen.Client.Schema

  @keys [:points, :company]

  defstruct [
    :points,
    :company
  ]

  @type t :: %__MODULE__{
          points: integer(),
          company: %{name: String.t(), id: Torngen.Client.Schema.CompanyTypeId.t()}
        }

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      points: data |> Map.get("points") |> Torngen.Client.Schema.parse({:static, :integer}),
      company:
        data
        |> Map.get("company")
        |> Torngen.Client.Schema.parse(
          {:object, %{id: {:ref, Torngen.Client.Schema.CompanyTypeId}, name: {:static, :string}}}
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

  defp validate_key?(:points, value) do
    Torngen.Client.Schema.validate?(value, {:static, :integer})
  end

  defp validate_key?(:company, value) do
    Torngen.Client.Schema.validate?(
      value,
      {:object, %{id: {:ref, Torngen.Client.Schema.CompanyTypeId}, name: {:static, :string}}}
    )
  end

  @spec keys() :: list(atom())
  def keys(), do: @keys
end
