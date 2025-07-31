defmodule Torngen.Client.Schema.PersonalStatsCommunication do
  @moduledoc false

  use Torngen.Client.SchemaObjectAccess, deprecated: []

  @behaviour Torngen.Client.Schema

  @keys [:communication]

  defstruct [
    :communication
  ]

  @type t :: %__MODULE__{
          communication: %{
            :personals => integer(),
            :mails_sent => %{
              :total => integer(),
              :spouse => integer(),
              :friends => integer(),
              :faction => integer(),
              :colleagues => integer()
            },
            :classified_ads => integer()
          }
        }

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      communication:
        data
        |> Map.get("communication")
        |> Torngen.Client.Schema.parse(
          {:object,
           %{
             personals: {:static, :integer},
             mails_sent:
               {:object,
                %{
                  total: {:static, :integer},
                  faction: {:static, :integer},
                  spouse: {:static, :integer},
                  friends: {:static, :integer},
                  colleagues: {:static, :integer}
                }},
             classified_ads: {:static, :integer}
           }}
        )
    }
  end

  @impl true
  def parse(_data), do: nil

  @impl true
  def validate?(%{} = data) do
    @keys
    |> Enum.map(fn key -> {key, Map.get(data, Atom.to_string(key))} end)
    |> Enum.map(fn {key, value} -> validate_key?(key, value) end)
    |> Enum.all?()
  end

  defp validate_key?(:communication, value) do
    Torngen.Client.Schema.validate?(
      value,
      {:object,
       %{
         personals: {:static, :integer},
         mails_sent:
           {:object,
            %{
              total: {:static, :integer},
              faction: {:static, :integer},
              spouse: {:static, :integer},
              friends: {:static, :integer},
              colleagues: {:static, :integer}
            }},
         classified_ads: {:static, :integer}
       }}
    )
  end

  @spec keys() :: list(atom())
  def keys(), do: @keys
end
