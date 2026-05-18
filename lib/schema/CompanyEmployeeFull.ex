defmodule Torngen.Client.Schema.CompanyEmployeeFull do
  @moduledoc false

  @behaviour Torngen.Client.Schema

  defstruct [:values]

  @type t :: %__MODULE__{
          values: [
            %{wage: integer(), value: nil | integer(), joined_at: integer()}
            | Torngen.Client.Schema.CompanyEmployeeExtended.t()
          ]
        }
  @types [
    {:object,
     %{
       value: {:one_of, [static: :null, static: :integer]},
       wage: {:static, :integer},
       joined_at: {:static, :integer}
     }},
    {:ref, Torngen.Client.Schema.CompanyEmployeeExtended}
  ]

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      values: [
        data
        |> Torngen.Client.Schema.parse(
          {:object,
           %{
             value: {:one_of, [static: :null, static: :integer]},
             wage: {:static, :integer},
             joined_at: {:static, :integer}
           }}
        ),
        data |> Torngen.Client.Schema.parse({:ref, Torngen.Client.Schema.CompanyEmployeeExtended})
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
