defmodule Torngen.Client.Schema.PointsMarketResponse do
  @moduledoc false

  use Torngen.Client.SchemaObjectAccess, deprecated: []

  @behaviour Torngen.Client.Schema

  @keys [:pointsmarket]

  defstruct [
    :pointsmarket
  ]

  @type t :: %__MODULE__{
          pointsmarket: [
            %{total_cost: integer(), quantity: integer(), id: integer(), cost: integer()}
          ]
        }

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      pointsmarket:
        data
        |> Map.get("pointsmarket")
        |> Torngen.Client.Schema.parse(
          {:array,
           {:object,
            %{
              id: {:static, :integer},
              cost: {:static, :integer},
              quantity: {:static, :integer},
              total_cost: {:static, :integer}
            }}}
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

  defp validate_key?(:pointsmarket, value) do
    Torngen.Client.Schema.validate?(
      value,
      {:array,
       {:object,
        %{
          id: {:static, :integer},
          cost: {:static, :integer},
          quantity: {:static, :integer},
          total_cost: {:static, :integer}
        }}}
    )
  end

  @spec keys() :: list(atom())
  def keys(), do: @keys
end
