defmodule Torngen.Client.Schema.UserRaceDetails do
  @moduledoc false

  @behaviour Torngen.Client.Schema

  defstruct [:values]

  @type t :: %__MODULE__{
          values: [
            %{skill_gain: integer() | float()} | Torngen.Client.Schema.RacingRaceDetails.t()
          ]
        }
  @types [
    {:object, %{skill_gain: {:static, :number}}},
    {:ref, Torngen.Client.Schema.RacingRaceDetails}
  ]

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      values: [
        data |> Torngen.Client.Schema.parse({:object, %{skill_gain: {:static, :number}}}),
        data |> Torngen.Client.Schema.parse({:ref, Torngen.Client.Schema.RacingRaceDetails})
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
