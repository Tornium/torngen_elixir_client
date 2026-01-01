defmodule Torngen.Client.Schema.TornEliminationTeamLeader do
  @moduledoc false

  @behaviour Torngen.Client.Schema

  defstruct [:values]

  @type t :: %__MODULE__{values: [%{active: boolean()} | Torngen.Client.Schema.BasicUser.t()]}

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
  def validate?(%{} = _data), do: true

  @impl true
  def validate?(_data), do: false
end
