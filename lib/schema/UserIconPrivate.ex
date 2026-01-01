defmodule Torngen.Client.Schema.UserIconPrivate do
  @moduledoc false

  @behaviour Torngen.Client.Schema

  defstruct [:values]

  @type t :: %__MODULE__{
          values: [%{until: nil | integer()} | Torngen.Client.Schema.UserIconPublic.t()]
        }

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      values: [
        data
        |> Torngen.Client.Schema.parse(
          {:object, %{until: {:one_of, [static: :null, static: :integer]}}}
        ),
        data |> Torngen.Client.Schema.parse({:ref, Torngen.Client.Schema.UserIconPublic})
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
