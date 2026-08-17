defmodule Torngen.Client.Schema.UserRaceCarDetails do
  @moduledoc false

  @behaviour Torngen.Client.Schema

  defstruct [:values]

  @type t :: %__MODULE__{
          values: [
            %{
              worth: integer(),
              races_won: integer(),
              races_entered: integer(),
              points_spent: integer(),
              parts: [Torngen.Client.Schema.RaceCarUpgradeId.t()],
              is_removed: boolean(),
              id: Torngen.Client.Schema.RaceCarId.t(),
              car_name: nil | nil | String.t()
            }
            | Torngen.Client.Schema.RaceCar.t()
          ]
        }
  @types [
    {:object,
     %{
       id: {:ref, Torngen.Client.Schema.RaceCarId},
       parts: {:array, {:ref, Torngen.Client.Schema.RaceCarUpgradeId}},
       car_name: {:one_of, [static: :null, one_of: [static: :null, static: :string]]},
       worth: {:static, :integer},
       races_won: {:static, :integer},
       races_entered: {:static, :integer},
       points_spent: {:static, :integer},
       is_removed: {:static, :boolean}
     }},
    {:ref, Torngen.Client.Schema.RaceCar}
  ]

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      values: [
        data
        |> Torngen.Client.Schema.parse(
          {:object,
           %{
             id: {:ref, Torngen.Client.Schema.RaceCarId},
             parts: {:array, {:ref, Torngen.Client.Schema.RaceCarUpgradeId}},
             car_name: {:one_of, [static: :null, one_of: [static: :null, static: :string]]},
             worth: {:static, :integer},
             races_won: {:static, :integer},
             races_entered: {:static, :integer},
             points_spent: {:static, :integer},
             is_removed: {:static, :boolean}
           }}
        ),
        data |> Torngen.Client.Schema.parse({:ref, Torngen.Client.Schema.RaceCar})
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
