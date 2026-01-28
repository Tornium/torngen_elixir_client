defmodule Torngen.Client.Schema.Report do
  @moduledoc false

  @behaviour Torngen.Client.Schema

  defstruct [:values]

  @type t :: %__MODULE__{
          values: [Torngen.Client.Schema.ReportReport.t() | Torngen.Client.Schema.ReportBase.t()]
        }
  @types [{:ref, Torngen.Client.Schema.ReportReport}, {:ref, Torngen.Client.Schema.ReportBase}]

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      values: [
        data |> Torngen.Client.Schema.parse({:ref, Torngen.Client.Schema.ReportReport}),
        data |> Torngen.Client.Schema.parse({:ref, Torngen.Client.Schema.ReportBase})
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
