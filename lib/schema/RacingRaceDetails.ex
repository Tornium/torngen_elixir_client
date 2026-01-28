defmodule Torngen.Client.Schema.RacingRaceDetails do
  @moduledoc false

  @behaviour Torngen.Client.Schema

  defstruct [:values]

  @type t :: %__MODULE__{
          values: [
            %{results: [Torngen.Client.Schema.RacerDetails.t()], is_official: boolean()}
            | Torngen.Client.Schema.Race.t()
          ]
        }
  @types [
    {:object,
     %{
       is_official: {:static, :boolean},
       results: {:array, {:ref, Torngen.Client.Schema.RacerDetails}}
     }},
    {:ref, Torngen.Client.Schema.Race}
  ]

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      values: [
        data
        |> Torngen.Client.Schema.parse(
          {:object,
           %{
             is_official: {:static, :boolean},
             results: {:array, {:ref, Torngen.Client.Schema.RacerDetails}}
           }}
        ),
        data |> Torngen.Client.Schema.parse({:ref, Torngen.Client.Schema.Race})
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
