defmodule Torngen.Client.Schema.TornStockDetailed do
  @moduledoc false

  @behaviour Torngen.Client.Schema

  defstruct [:values]

  @type t :: %__MODULE__{
          values: [
            %{
              chart: %{
                performance: %{
                  last_year: Torngen.Client.Schema.TornStockPerformance.t(),
                  last_week: Torngen.Client.Schema.TornStockPerformance.t(),
                  last_month: Torngen.Client.Schema.TornStockPerformance.t(),
                  last_hour: Torngen.Client.Schema.TornStockPerformance.t(),
                  last_day: Torngen.Client.Schema.TornStockPerformance.t(),
                  all_time: Torngen.Client.Schema.TornStockPerformance.t()
                },
                history: [Torngen.Client.Schema.TornStockHistory.t()]
              }
            }
            | Torngen.Client.Schema.TornStock.t()
          ]
        }
  @types [
    {:object,
     %{
       chart:
         {:object,
          %{
            history: {:array, {:ref, Torngen.Client.Schema.TornStockHistory}},
            performance:
              {:object,
               %{
                 last_year: {:ref, Torngen.Client.Schema.TornStockPerformance},
                 last_week: {:ref, Torngen.Client.Schema.TornStockPerformance},
                 last_month: {:ref, Torngen.Client.Schema.TornStockPerformance},
                 last_hour: {:ref, Torngen.Client.Schema.TornStockPerformance},
                 last_day: {:ref, Torngen.Client.Schema.TornStockPerformance},
                 all_time: {:ref, Torngen.Client.Schema.TornStockPerformance}
               }}
          }}
     }},
    {:ref, Torngen.Client.Schema.TornStock}
  ]

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      values: [
        data
        |> Torngen.Client.Schema.parse(
          {:object,
           %{
             chart:
               {:object,
                %{
                  history: {:array, {:ref, Torngen.Client.Schema.TornStockHistory}},
                  performance:
                    {:object,
                     %{
                       last_year: {:ref, Torngen.Client.Schema.TornStockPerformance},
                       last_week: {:ref, Torngen.Client.Schema.TornStockPerformance},
                       last_month: {:ref, Torngen.Client.Schema.TornStockPerformance},
                       last_hour: {:ref, Torngen.Client.Schema.TornStockPerformance},
                       last_day: {:ref, Torngen.Client.Schema.TornStockPerformance},
                       all_time: {:ref, Torngen.Client.Schema.TornStockPerformance}
                     }}
                }}
           }}
        ),
        data |> Torngen.Client.Schema.parse({:ref, Torngen.Client.Schema.TornStock})
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
