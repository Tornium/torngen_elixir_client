defmodule Torngen.Client.Schema.UserTravelResponse do
  @moduledoc false

  use Torngen.Client.SchemaObjectAccess, deprecated: []

  @behaviour Torngen.Client.Schema

  @keys [:travel]

  defstruct [
    :travel
  ]

  @type t :: %__MODULE__{
          travel: %{
            :time_left => integer(),
            :method => nil | Torngen.Client.Schema.UserFlyMethodEnum.t(),
            :destination => Torngen.Client.Schema.CountryEnum.t(),
            :departed_at => nil | integer(),
            :arrival_at => nil | integer()
          }
        }

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      travel:
        data
        |> Map.get("travel")
        |> Torngen.Client.Schema.parse(
          {:object,
           %{
             time_left: {:static, :integer},
             destination: Torngen.Client.Schema.CountryEnum,
             method: {:one_of, [{:static, :null}, Torngen.Client.Schema.UserFlyMethodEnum]},
             departed_at: {:one_of, [static: :null, static: :integer]},
             arrival_at: {:one_of, [static: :null, static: :integer]}
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

  defp validate_key?(:travel, value) do
    Torngen.Client.Schema.validate?(
      value,
      {:object,
       %{
         time_left: {:static, :integer},
         destination: Torngen.Client.Schema.CountryEnum,
         method: {:one_of, [{:static, :null}, Torngen.Client.Schema.UserFlyMethodEnum]},
         departed_at: {:one_of, [static: :null, static: :integer]},
         arrival_at: {:one_of, [static: :null, static: :integer]}
       }}
    )
  end

  @spec keys() :: list(atom())
  def keys(), do: @keys
end
