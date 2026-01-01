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
              name: nil | String.t(),
              is_removed: boolean(),
              id: Torngen.Client.Schema.RaceCarId.t()
            }
            | Torngen.Client.Schema.RaceCar.t()
          ]
        }

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      values: [
        data
        |> Torngen.Client.Schema.parse(
          {:object,
           %{
             id: {:ref, Torngen.Client.Schema.RaceCarId},
             name: {:one_of, [static: :null, static: :string]},
             parts: {:array, {:ref, Torngen.Client.Schema.RaceCarUpgradeId}},
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
  def validate?(%{} = _data), do: true

  @impl true
  def validate?(_data), do: false
end
