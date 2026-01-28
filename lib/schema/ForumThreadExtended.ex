defmodule Torngen.Client.Schema.ForumThreadExtended do
  @moduledoc false

  @behaviour Torngen.Client.Schema

  defstruct [:values]

  @type t :: %__MODULE__{
          values: [
            %{
              poll: nil | Torngen.Client.Schema.ForumPoll.t(),
              content_raw: String.t(),
              content: String.t()
            }
            | Torngen.Client.Schema.ForumThreadBase.t()
          ]
        }
  @types [
    {:object,
     %{
       content: {:static, :string},
       poll: {:one_of, [static: :null, ref: Torngen.Client.Schema.ForumPoll]},
       content_raw: {:static, :string}
     }},
    {:ref, Torngen.Client.Schema.ForumThreadBase}
  ]

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      values: [
        data
        |> Torngen.Client.Schema.parse(
          {:object,
           %{
             content: {:static, :string},
             poll: {:one_of, [static: :null, ref: Torngen.Client.Schema.ForumPoll]},
             content_raw: {:static, :string}
           }}
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
