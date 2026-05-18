defmodule Torngen.Client.Schema.CompanyEmployeeExtended do
  @moduledoc false

  @behaviour Torngen.Client.Schema

  defstruct [:values]

  @type t :: %__MODULE__{
          values: [
            %{
              stats: Torngen.Client.Schema.CompanyEmployeeStats.t(),
              effectiveness: Torngen.Client.Schema.CompanyEmployeeEffectiveness.t()
            }
            | Torngen.Client.Schema.CompanyEmployee.t()
          ]
        }
  @types [
    {:object,
     %{
       stats: {:ref, Torngen.Client.Schema.CompanyEmployeeStats},
       effectiveness: {:ref, Torngen.Client.Schema.CompanyEmployeeEffectiveness}
     }},
    {:ref, Torngen.Client.Schema.CompanyEmployee}
  ]

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      values: [
        data
        |> Torngen.Client.Schema.parse(
          {:object,
           %{
             stats: {:ref, Torngen.Client.Schema.CompanyEmployeeStats},
             effectiveness: {:ref, Torngen.Client.Schema.CompanyEmployeeEffectiveness}
           }}
        ),
        data |> Torngen.Client.Schema.parse({:ref, Torngen.Client.Schema.CompanyEmployee})
      ]
    }
  end

  @impl true
  def parse(_data), do: nil

  @impl true
  def validate?(data) do
    Enum.all?(@types, fn type -> Torngen.Client.Schema.validate?(data, type) end)
  end
end
