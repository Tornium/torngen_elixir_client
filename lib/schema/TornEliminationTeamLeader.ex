defmodule Torngen.Client.Schema.TornEliminationTeamLeader do
  @moduledoc false

  @behaviour Torngen.Client.Schema

  defstruct [:values]

  @type t :: %__MODULE__{values: [%{active: boolean()} | Torngen.Client.Schema.BasicUser.t()]}
  @types [{:object, %{active: {:static, :boolean}}}, {:ref, Torngen.Client.Schema.BasicUser}]

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      values: [
        data |> Torngen.Client.Schema.parse({:object, %{active: {:static, :boolean}}}),
        data |> Torngen.Client.Schema.parse({:ref, Torngen.Client.Schema.BasicUser})
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
