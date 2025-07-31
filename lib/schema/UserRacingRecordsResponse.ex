defmodule Torngen.Client.Schema.UserRacingRecordsResponse do
  @moduledoc false

  use Torngen.Client.SchemaObjectAccess, deprecated: []

  @behaviour Torngen.Client.Schema

  @keys [:racingrecords]

  defstruct [
    :racingrecords
  ]

  @type t :: %__MODULE__{
          racingrecords: [
            %{
              :track => %{:name => String.t(), :id => Torngen.Client.Schema.RaceTrackId.t()},
              :records => [
                %{
                  :lap_time => integer(),
                  :car_name => String.t(),
                  :car_id => Torngen.Client.Schema.ItemId.t()
                }
              ]
            }
          ]
        }

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      racingrecords:
        data
        |> Map.get("racingrecords")
        |> Torngen.Client.Schema.parse(
          {:array,
           {:object,
            %{
              track:
                {:object, %{id: Torngen.Client.Schema.RaceTrackId, name: {:static, :string}}},
              records:
                {:array,
                 {:object,
                  %{
                    lap_time: {:static, :integer},
                    car_name: {:static, :string},
                    car_id: Torngen.Client.Schema.ItemId
                  }}}
            }}}
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

  defp validate_key?(:racingrecords, value) do
    Torngen.Client.Schema.validate?(
      value,
      {:array,
       {:object,
        %{
          track: {:object, %{id: Torngen.Client.Schema.RaceTrackId, name: {:static, :string}}},
          records:
            {:array,
             {:object,
              %{
                lap_time: {:static, :integer},
                car_name: {:static, :string},
                car_id: Torngen.Client.Schema.ItemId
              }}}
        }}}
    )
  end

  @spec keys() :: list(atom())
  def keys(), do: @keys
end
