defmodule Torngen.Client.Schema.FactionBalance do
  @moduledoc false

  use Torngen.Client.SchemaObjectAccess, deprecated: []

  @behaviour Torngen.Client.Schema

  @keys [:members, :faction]

  defstruct [
    :members,
    :faction
  ]

  @type t :: %__MODULE__{
          members: [
            %{
              :username => String.t(),
              :points => integer(),
              :money => integer(),
              :id => Torngen.Client.Schema.UserId.t()
            }
          ],
          faction: %{:scope => integer(), :points => integer(), :money => integer()}
        }

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      members:
        data
        |> Map.get("members")
        |> Torngen.Client.Schema.parse(
          {:array,
           {:object,
            %{
              "id" => Torngen.Client.Schema.UserId,
              "money" => {:static, :integer},
              "points" => {:static, :integer},
              "username" => {:static, :string}
            }}}
        ),
      faction:
        data
        |> Map.get("faction")
        |> Torngen.Client.Schema.parse(
          {:object,
           %{
             "money" => {:static, :integer},
             "points" => {:static, :integer},
             "scope" => {:static, :integer}
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

  defp validate_key?(:members, value) do
    Torngen.Client.Schema.validate?(
      value,
      {:array,
       {:object,
        %{
          "id" => Torngen.Client.Schema.UserId,
          "money" => {:static, :integer},
          "points" => {:static, :integer},
          "username" => {:static, :string}
        }}}
    )
  end

  defp validate_key?(:faction, value) do
    Torngen.Client.Schema.validate?(
      value,
      {:object,
       %{
         "money" => {:static, :integer},
         "points" => {:static, :integer},
         "scope" => {:static, :integer}
       }}
    )
  end

  @spec keys() :: list(atom())
  def keys(), do: @keys
end
