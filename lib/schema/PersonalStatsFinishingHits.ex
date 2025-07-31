defmodule Torngen.Client.Schema.PersonalStatsFinishingHits do
  @moduledoc false

  use Torngen.Client.SchemaObjectAccess, deprecated: []

  @behaviour Torngen.Client.Schema

  @keys [:finishing_hits]

  defstruct [
    :finishing_hits
  ]

  @type t :: %__MODULE__{
          finishing_hits: %{
            :temporary => integer(),
            :sub_machine_guns => integer(),
            :slashing => integer(),
            :shotguns => integer(),
            :rifles => integer(),
            :pistols => integer(),
            :piercing => integer(),
            :mechanical => integer(),
            :machine_guns => integer(),
            :heavy_artillery => integer(),
            :hand_to_hand => integer(),
            :clubbing => integer()
          }
        }

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      finishing_hits:
        data
        |> Map.get("finishing_hits")
        |> Torngen.Client.Schema.parse(
          {:object,
           %{
             temporary: {:static, :integer},
             piercing: {:static, :integer},
             sub_machine_guns: {:static, :integer},
             slashing: {:static, :integer},
             shotguns: {:static, :integer},
             rifles: {:static, :integer},
             pistols: {:static, :integer},
             mechanical: {:static, :integer},
             machine_guns: {:static, :integer},
             heavy_artillery: {:static, :integer},
             hand_to_hand: {:static, :integer},
             clubbing: {:static, :integer}
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

  defp validate_key?(:finishing_hits, value) do
    Torngen.Client.Schema.validate?(
      value,
      {:object,
       %{
         temporary: {:static, :integer},
         piercing: {:static, :integer},
         sub_machine_guns: {:static, :integer},
         slashing: {:static, :integer},
         shotguns: {:static, :integer},
         rifles: {:static, :integer},
         pistols: {:static, :integer},
         mechanical: {:static, :integer},
         machine_guns: {:static, :integer},
         heavy_artillery: {:static, :integer},
         hand_to_hand: {:static, :integer},
         clubbing: {:static, :integer}
       }}
    )
  end

  @spec keys() :: list(atom())
  def keys(), do: @keys
end
