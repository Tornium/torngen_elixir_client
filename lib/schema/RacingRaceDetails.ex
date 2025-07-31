defmodule Torngen.Client.Schema.RacingRaceDetails do
  @moduledoc false

  @behaviour Torngen.Client.Schema

  defstruct [:values]

  @type t :: %__MODULE__{
          values: [
            %{:results => [Torngen.Client.Schema.RacerDetails.t()], :is_official => boolean()}
            | Torngen.Client.Schema.Race.t()
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
             results: {:array, Torngen.Client.Schema.RacerDetails},
             is_official: {:static, :boolean}
           }}
        ),
        data |> Torngen.Client.Schema.parse(Torngen.Client.Schema.Race)
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
