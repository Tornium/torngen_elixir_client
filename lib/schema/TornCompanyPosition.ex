defmodule Torngen.Client.Schema.TornCompanyPosition do
  @moduledoc false

  use Torngen.Client.SchemaObjectAccess, deprecated: []

  @behaviour Torngen.Client.Schema

  @keys [:working_stats, :name, :id, :description, :ability]

  defstruct [
    :working_stats,
    :name,
    :id,
    :description,
    :ability
  ]

  @type t :: %__MODULE__{
          working_stats: %{
            required: %{manual_labor: integer(), intelligence: integer(), endurance: integer()},
            daily_gains: %{manual_labor: integer(), intelligence: integer(), endurance: integer()}
          },
          name: String.t(),
          id: Torngen.Client.Schema.CompanyPositionId.t(),
          description: String.t(),
          ability: String.t()
        }

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      working_stats:
        data
        |> Map.get("working_stats")
        |> Torngen.Client.Schema.parse(
          {:object,
           %{
             required:
               {:object,
                %{
                  intelligence: {:static, :integer},
                  endurance: {:static, :integer},
                  manual_labor: {:static, :integer}
                }},
             daily_gains:
               {:object,
                %{
                  intelligence: {:static, :integer},
                  endurance: {:static, :integer},
                  manual_labor: {:static, :integer}
                }}
           }}
        ),
      name: data |> Map.get("name") |> Torngen.Client.Schema.parse({:static, :string}),
      id:
        data
        |> Map.get("id")
        |> Torngen.Client.Schema.parse({:ref, Torngen.Client.Schema.CompanyPositionId}),
      description:
        data |> Map.get("description") |> Torngen.Client.Schema.parse({:static, :string}),
      ability: data |> Map.get("ability") |> Torngen.Client.Schema.parse({:static, :string})
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

  defp validate_key?(:working_stats, value) do
    Torngen.Client.Schema.validate?(
      value,
      {:object,
       %{
         required:
           {:object,
            %{
              intelligence: {:static, :integer},
              endurance: {:static, :integer},
              manual_labor: {:static, :integer}
            }},
         daily_gains:
           {:object,
            %{
              intelligence: {:static, :integer},
              endurance: {:static, :integer},
              manual_labor: {:static, :integer}
            }}
       }}
    )
  end

  defp validate_key?(:name, value) do
    Torngen.Client.Schema.validate?(value, {:static, :string})
  end

  defp validate_key?(:id, value) do
    Torngen.Client.Schema.validate?(value, {:ref, Torngen.Client.Schema.CompanyPositionId})
  end

  defp validate_key?(:description, value) do
    Torngen.Client.Schema.validate?(value, {:static, :string})
  end

  defp validate_key?(:ability, value) do
    Torngen.Client.Schema.validate?(value, {:static, :string})
  end

  @spec keys() :: list(atom())
  def keys(), do: @keys
end
