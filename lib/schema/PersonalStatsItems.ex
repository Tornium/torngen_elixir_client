defmodule Torngen.Client.Schema.PersonalStatsItems do
  @moduledoc false

  use Torngen.Client.SchemaObjectAccess, deprecated: []

  @behaviour Torngen.Client.Schema

  @keys [:items]

  defstruct [
    :items
  ]

  @type t :: %__MODULE__{
          items: %{
            :viruses_coded => integer(),
            :used => %{
              :stat_enhancers => integer(),
              :energy_drinks => integer(),
              :easter_eggs => integer(),
              :consumables => integer(),
              :candy => integer(),
              :boosters => integer(),
              :books => integer(),
              :alcohol => integer()
            },
            :trashed => integer(),
            :found => %{:easter_eggs => integer(), :dump => integer(), :city => integer()}
          }
        }

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      items:
        data
        |> Map.get("items")
        |> Torngen.Client.Schema.parse(
          {:object,
           %{
             used:
               {:object,
                %{
                  stat_enhancers: {:static, :integer},
                  energy_drinks: {:static, :integer},
                  easter_eggs: {:static, :integer},
                  consumables: {:static, :integer},
                  candy: {:static, :integer},
                  boosters: {:static, :integer},
                  books: {:static, :integer},
                  alcohol: {:static, :integer}
                }},
             found:
               {:object,
                %{
                  easter_eggs: {:static, :integer},
                  dump: {:static, :integer},
                  city: {:static, :integer}
                }},
             viruses_coded: {:static, :integer},
             trashed: {:static, :integer}
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

  defp validate_key?(:items, value) do
    Torngen.Client.Schema.validate?(
      value,
      {:object,
       %{
         used:
           {:object,
            %{
              stat_enhancers: {:static, :integer},
              energy_drinks: {:static, :integer},
              easter_eggs: {:static, :integer},
              consumables: {:static, :integer},
              candy: {:static, :integer},
              boosters: {:static, :integer},
              books: {:static, :integer},
              alcohol: {:static, :integer}
            }},
         found:
           {:object,
            %{
              easter_eggs: {:static, :integer},
              dump: {:static, :integer},
              city: {:static, :integer}
            }},
         viruses_coded: {:static, :integer},
         trashed: {:static, :integer}
       }}
    )
  end

  @spec keys() :: list(atom())
  def keys(), do: @keys
end
