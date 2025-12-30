defmodule Torngen.Client.Schema.UserRaceDetails do
  @moduledoc false

  @behaviour Torngen.Client.Schema

  defstruct [:values]

  @type t :: %__MODULE__{
          values: [%{:skill_gain => term()} | Torngen.Client.Schema.RacingRaceDetails.t()]
        }

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      values: [
        data |> Torngen.Client.Schema.parse({:object, %{skill_gain: :any}}),
        data |> Torngen.Client.Schema.parse(Torngen.Client.Schema.RacingRaceDetails)
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
