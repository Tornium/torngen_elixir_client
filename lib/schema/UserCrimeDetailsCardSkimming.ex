defmodule Torngen.Client.Schema.UserCrimeDetailsCardSkimming do
  @moduledoc false

  use Torngen.Client.SchemaObjectAccess, deprecated: []

  @behaviour Torngen.Client.Schema

  @keys [:skimmers, :card_details]

  defstruct [
    :skimmers,
    :card_details
  ]

  @type t :: %__MODULE__{
          skimmers: %{
            :oldest_recovered => integer(),
            :most_lucrative => integer(),
            :lost => integer(),
            :active => integer()
          },
          card_details: %{
            :sold => integer(),
            :recovered => integer(),
            :recoverable => integer(),
            :lost => integer(),
            :areas => [%{:id => integer(), :amount => integer()}]
          }
        }

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      skimmers:
        data
        |> Map.get("skimmers")
        |> Torngen.Client.Schema.parse(
          {:object,
           %{
             active: {:static, :integer},
             lost: {:static, :integer},
             oldest_recovered: {:static, :integer},
             most_lucrative: {:static, :integer}
           }}
        ),
      card_details:
        data
        |> Map.get("card_details")
        |> Torngen.Client.Schema.parse(
          {:object,
           %{
             lost: {:static, :integer},
             sold: {:static, :integer},
             recovered: {:static, :integer},
             recoverable: {:static, :integer},
             areas: {:array, {:object, %{id: {:static, :integer}, amount: {:static, :integer}}}}
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

  defp validate_key?(:skimmers, value) do
    Torngen.Client.Schema.validate?(
      value,
      {:object,
       %{
         active: {:static, :integer},
         lost: {:static, :integer},
         oldest_recovered: {:static, :integer},
         most_lucrative: {:static, :integer}
       }}
    )
  end

  defp validate_key?(:card_details, value) do
    Torngen.Client.Schema.validate?(
      value,
      {:object,
       %{
         lost: {:static, :integer},
         sold: {:static, :integer},
         recovered: {:static, :integer},
         recoverable: {:static, :integer},
         areas: {:array, {:object, %{id: {:static, :integer}, amount: {:static, :integer}}}}
       }}
    )
  end

  @spec keys() :: list(atom())
  def keys(), do: @keys
end
