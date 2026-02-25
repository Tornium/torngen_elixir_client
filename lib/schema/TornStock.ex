defmodule Torngen.Client.Schema.TornStock do
  @moduledoc false

  use Torngen.Client.SchemaObjectAccess, deprecated: []

  @behaviour Torngen.Client.Schema

  @keys [:name, :market, :images, :id, :bonus, :acronym]

  defstruct [
    :name,
    :market,
    :images,
    :id,
    :bonus,
    :acronym
  ]

  @type t :: %__MODULE__{
          name: String.t(),
          market: %{
            shares: integer(),
            price: integer() | float(),
            investors: integer(),
            cap: integer()
          },
          images: %{logo: String.t(), full: String.t()},
          id: Torngen.Client.Schema.StockId.t(),
          bonus: %{
            requirement: integer(),
            passive: boolean(),
            frequency: integer(),
            description: String.t()
          },
          acronym: String.t()
        }

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      name: data |> Map.get("name") |> Torngen.Client.Schema.parse({:static, :string}),
      market:
        data
        |> Map.get("market")
        |> Torngen.Client.Schema.parse(
          {:object,
           %{
             shares: {:static, :integer},
             price: {:static, :number},
             investors: {:static, :integer},
             cap: {:static, :integer}
           }}
        ),
      images:
        data
        |> Map.get("images")
        |> Torngen.Client.Schema.parse(
          {:object, %{full: {:static, :string}, logo: {:static, :string}}}
        ),
      id:
        data
        |> Map.get("id")
        |> Torngen.Client.Schema.parse({:ref, Torngen.Client.Schema.StockId}),
      bonus:
        data
        |> Map.get("bonus")
        |> Torngen.Client.Schema.parse(
          {:object,
           %{
             passive: {:static, :boolean},
             description: {:static, :string},
             requirement: {:static, :integer},
             frequency: {:static, :integer}
           }}
        ),
      acronym: data |> Map.get("acronym") |> Torngen.Client.Schema.parse({:static, :string})
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

  defp validate_key?(:name, value) do
    Torngen.Client.Schema.validate?(value, {:static, :string})
  end

  defp validate_key?(:market, value) do
    Torngen.Client.Schema.validate?(
      value,
      {:object,
       %{
         shares: {:static, :integer},
         price: {:static, :number},
         investors: {:static, :integer},
         cap: {:static, :integer}
       }}
    )
  end

  defp validate_key?(:images, value) do
    Torngen.Client.Schema.validate?(
      value,
      {:object, %{full: {:static, :string}, logo: {:static, :string}}}
    )
  end

  defp validate_key?(:id, value) do
    Torngen.Client.Schema.validate?(value, {:ref, Torngen.Client.Schema.StockId})
  end

  defp validate_key?(:bonus, value) do
    Torngen.Client.Schema.validate?(
      value,
      {:object,
       %{
         passive: {:static, :boolean},
         description: {:static, :string},
         requirement: {:static, :integer},
         frequency: {:static, :integer}
       }}
    )
  end

  defp validate_key?(:acronym, value) do
    Torngen.Client.Schema.validate?(value, {:static, :string})
  end

  @spec keys() :: list(atom())
  def keys(), do: @keys
end
