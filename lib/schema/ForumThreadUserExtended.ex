defmodule Torngen.Client.Schema.ForumThreadUserExtended do
  @moduledoc false

  @behaviour Torngen.Client.Schema

  defstruct [:values]

  @type t :: %__MODULE__{
          values: [%{:new_posts => nil | integer()} | Torngen.Client.Schema.ForumThreadBase.t()]
        }

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      values: [
        data
        |> Torngen.Client.Schema.parse(
          {:object, %{"new_posts" => {:one_of, [static: :null, static: :integer]}}}
        ),
        data |> Torngen.Client.Schema.parse(Torngen.Client.Schema.ForumThreadBase)
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
