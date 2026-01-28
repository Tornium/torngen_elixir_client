defmodule Torngen.Client.Schema.FactionChainWarfare do
  @moduledoc false

  @behaviour Torngen.Client.Schema

  defstruct [:values]

  @type t :: %__MODULE__{
          values: [
            %{faction: %{name: String.t(), id: Torngen.Client.Schema.FactionId.t()}}
            | Torngen.Client.Schema.FactionChain.t()
          ]
        }
  @types [
    {:object,
     %{
       faction:
         {:object, %{id: {:ref, Torngen.Client.Schema.FactionId}, name: {:static, :string}}}
     }},
    {:ref, Torngen.Client.Schema.FactionChain}
  ]

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      values: [
        data
        |> Torngen.Client.Schema.parse(
          {:object,
           %{
             faction:
               {:object, %{id: {:ref, Torngen.Client.Schema.FactionId}, name: {:static, :string}}}
           }}
        ),
        data |> Torngen.Client.Schema.parse({:ref, Torngen.Client.Schema.FactionChain})
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
