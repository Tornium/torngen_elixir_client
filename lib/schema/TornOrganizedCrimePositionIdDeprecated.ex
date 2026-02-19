defmodule Torngen.Client.Schema.TornOrganizedCrimePositionIdDeprecated do
  @moduledoc false

  @behaviour Torngen.Client.Schema

  defstruct [:values]

  @type t :: %__MODULE__{values: [Torngen.Client.Schema.TornOrganizedCrimePositionId.t()]}
  @types [{:ref, Torngen.Client.Schema.TornOrganizedCrimePositionId}]

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      values: [
        data
        |> Torngen.Client.Schema.parse({:ref, Torngen.Client.Schema.TornOrganizedCrimePositionId})
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
