defmodule Torngen.Client.Schema.UserWorkStatsResponse do
  @moduledoc false

  use Torngen.Client.SchemaObjectAccess, deprecated: []

  @behaviour Torngen.Client.Schema

  @keys [:workstats]

  defstruct [
    :workstats
  ]

  @type t :: %__MODULE__{
          workstats: %{
            total: integer(),
            manual_labor: integer(),
            intelligence: integer(),
            endurance: integer()
          }
        }

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      workstats:
        data
        |> Map.get("workstats")
        |> Torngen.Client.Schema.parse(
          {:object,
           %{
             total: {:static, :integer},
             intelligence: {:static, :integer},
             endurance: {:static, :integer},
             manual_labor: {:static, :integer}
           }}
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

  defp validate_key?(:workstats, value) do
    Torngen.Client.Schema.validate?(
      value,
      {:object,
       %{
         total: {:static, :integer},
         intelligence: {:static, :integer},
         endurance: {:static, :integer},
         manual_labor: {:static, :integer}
       }}
    )
  end

  @spec keys() :: list(atom())
  def keys(), do: @keys
end
