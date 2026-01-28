defmodule Torngen.Client.Schema.ForumThreadUserExtended do
  @moduledoc false

  @behaviour Torngen.Client.Schema

  defstruct [:values]

  @type t :: %__MODULE__{
          values: [%{new_posts: nil | integer()} | Torngen.Client.Schema.ForumThreadBase.t()]
        }
  @types [
    {:object, %{new_posts: {:one_of, [static: :null, static: :integer]}}},
    {:ref, Torngen.Client.Schema.ForumThreadBase}
  ]

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      values: [
        data
        |> Torngen.Client.Schema.parse(
          {:object, %{new_posts: {:one_of, [static: :null, static: :integer]}}}
        ),
        data |> Torngen.Client.Schema.parse({:ref, Torngen.Client.Schema.ForumThreadBase})
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
