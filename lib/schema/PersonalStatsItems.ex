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
             "found" =>
               {:object,
                %{
                  "city" => {:static, :integer},
                  "dump" => {:static, :integer},
                  "easter_eggs" => {:static, :integer}
                }},
             "trashed" => {:static, :integer},
             "used" =>
               {:object,
                %{
                  "alcohol" => {:static, :integer},
                  "books" => {:static, :integer},
                  "boosters" => {:static, :integer},
                  "candy" => {:static, :integer},
                  "consumables" => {:static, :integer},
                  "easter_eggs" => {:static, :integer},
                  "energy_drinks" => {:static, :integer},
                  "stat_enhancers" => {:static, :integer}
                }},
             "viruses_coded" => {:static, :integer}
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
         "found" =>
           {:object,
            %{
              "city" => {:static, :integer},
              "dump" => {:static, :integer},
              "easter_eggs" => {:static, :integer}
            }},
         "trashed" => {:static, :integer},
         "used" =>
           {:object,
            %{
              "alcohol" => {:static, :integer},
              "books" => {:static, :integer},
              "boosters" => {:static, :integer},
              "candy" => {:static, :integer},
              "consumables" => {:static, :integer},
              "easter_eggs" => {:static, :integer},
              "energy_drinks" => {:static, :integer},
              "stat_enhancers" => {:static, :integer}
            }},
         "viruses_coded" => {:static, :integer}
       }}
    )
  end

  @spec keys() :: list(atom())
  def keys(), do: @keys
end
