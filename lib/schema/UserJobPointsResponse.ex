defmodule Torngen.Client.Schema.UserJobPointsResponse do
  @moduledoc false

  use Torngen.Client.SchemaObjectAccess, deprecated: []

  @behaviour Torngen.Client.Schema

  @keys [:jobpoints]

  defstruct [
    :jobpoints
  ]

  @type t :: %__MODULE__{
          jobpoints: %{
            :jobs => %{
              :medical => integer(),
              :law => integer(),
              :grocer => integer(),
              :education => integer(),
              :casino => integer(),
              :army => integer()
            },
            :companies => [Torngen.Client.Schema.UserCompanyPoints.t()]
          }
        }

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      jobpoints:
        data
        |> Map.get("jobpoints")
        |> Torngen.Client.Schema.parse(
          {:object,
           %{
             jobs:
               {:object,
                %{
                  medical: {:static, :integer},
                  law: {:static, :integer},
                  grocer: {:static, :integer},
                  education: {:static, :integer},
                  casino: {:static, :integer},
                  army: {:static, :integer}
                }},
             companies: {:array, Torngen.Client.Schema.UserCompanyPoints}
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

  defp validate_key?(:jobpoints, value) do
    Torngen.Client.Schema.validate?(
      value,
      {:object,
       %{
         jobs:
           {:object,
            %{
              medical: {:static, :integer},
              law: {:static, :integer},
              grocer: {:static, :integer},
              education: {:static, :integer},
              casino: {:static, :integer},
              army: {:static, :integer}
            }},
         companies: {:array, Torngen.Client.Schema.UserCompanyPoints}
       }}
    )
  end

  @spec keys() :: list(atom())
  def keys(), do: @keys
end
