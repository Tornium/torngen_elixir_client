defmodule Torngen.Client.Schema.Report do
  @moduledoc false

  @behaviour Torngen.Client.Schema

  defstruct [:values]

  @type t :: %__MODULE__{
          values: [Torngen.Client.Schema.ReportReport.t() | Torngen.Client.Schema.ReportBase.t()]
        }

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      values: [
        data |> Torngen.Client.Schema.parse(Torngen.Client.Schema.ReportReport),
        data |> Torngen.Client.Schema.parse(Torngen.Client.Schema.ReportBase)
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
