defmodule Torngen.Client.Schema.TornHofWithOffenses do
  @moduledoc false

  @behaviour Torngen.Client.Schema

  defstruct [:values]

  @type t :: %__MODULE__{
          values: [%{criminal_offenses: integer()} | Torngen.Client.Schema.TornHofBasic.t()]
        }
  @types [
    {:object, %{criminal_offenses: {:static, :integer}}},
    {:ref, Torngen.Client.Schema.TornHofBasic}
  ]

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      values: [
        data |> Torngen.Client.Schema.parse({:object, %{criminal_offenses: {:static, :integer}}}),
        data |> Torngen.Client.Schema.parse({:ref, Torngen.Client.Schema.TornHofBasic})
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
