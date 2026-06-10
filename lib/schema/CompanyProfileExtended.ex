defmodule Torngen.Client.Schema.CompanyProfileExtended do
  @moduledoc false

  @behaviour Torngen.Client.Schema

  defstruct [:values]

  @type t :: %__MODULE__{
          values: [
            %{
              value: integer(),
              upgrades: Torngen.Client.Schema.CompanyUpgrades.t(),
              trains: integer(),
              popularity: integer(),
              funds: integer(),
              environment: integer(),
              efficiency: integer(),
              advertisement_budget: integer()
            }
            | Torngen.Client.Schema.CompanyProfile.t()
          ]
        }
  @types [
    {:object,
     %{
       value: {:static, :integer},
       upgrades: {:ref, Torngen.Client.Schema.CompanyUpgrades},
       trains: {:static, :integer},
       popularity: {:static, :integer},
       funds: {:static, :integer},
       environment: {:static, :integer},
       efficiency: {:static, :integer},
       advertisement_budget: {:static, :integer}
     }},
    {:ref, Torngen.Client.Schema.CompanyProfile}
  ]

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      values: [
        data
        |> Torngen.Client.Schema.parse(
          {:object,
           %{
             value: {:static, :integer},
             upgrades: {:ref, Torngen.Client.Schema.CompanyUpgrades},
             trains: {:static, :integer},
             popularity: {:static, :integer},
             funds: {:static, :integer},
             environment: {:static, :integer},
             efficiency: {:static, :integer},
             advertisement_budget: {:static, :integer}
           }}
        ),
        data |> Torngen.Client.Schema.parse({:ref, Torngen.Client.Schema.CompanyProfile})
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
