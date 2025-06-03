defmodule Torngen.Client.Schema.FactionChainWarfare do
  @moduledoc false

  @behaviour Torngen.Client.Schema

  defstruct [:values]

  @type t :: %__MODULE__{
          values: [
            %{:faction => %{:name => String.t(), :id => Torngen.Client.Schema.FactionId.t()}}
            | Torngen.Client.Schema.FactionChain.t()
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
             "faction" =>
               {:object, %{"id" => Torngen.Client.Schema.FactionId, "name" => {:static, :string}}}
           }}
        ),
        data |> Torngen.Client.Schema.parse(Torngen.Client.Schema.FactionChain)
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
