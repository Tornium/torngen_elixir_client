defmodule Torngen.Client.Schema.TornFactionTreeBranch do
  @moduledoc false

  use Torngen.Client.SchemaObjectAccess, deprecated: []

  @behaviour Torngen.Client.Schema

  @keys [:upgrades, :name, :id]

  defstruct [
    :upgrades,
    :name,
    :id
  ]

  @type t :: %__MODULE__{
          upgrades: [
            %{
              :name => String.t(),
              :level => integer(),
              :cost => integer(),
              :challenge =>
                nil
                | %{
                    :stat => Torngen.Client.Schema.FactionStatEnum.t(),
                    :description => String.t(),
                    :amount_required => integer()
                  },
              :ability => String.t()
            }
          ],
          name: String.t(),
          id: Torngen.Client.Schema.FactionBranchId.t()
        }

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      upgrades:
        data
        |> Map.get("upgrades")
        |> Torngen.Client.Schema.parse(
          {:array,
           {:object,
            %{
              "ability" => {:static, :string},
              "challenge" =>
                {:one_of,
                 [
                   static: :null,
                   object: %{
                     "amount_required" => {:static, :integer},
                     "description" => {:static, :string},
                     "stat" => Torngen.Client.Schema.FactionStatEnum
                   }
                 ]},
              "cost" => {:static, :integer},
              "level" => {:static, :integer},
              "name" => {:static, :string}
            }}}
        ),
      name: data |> Map.get("name") |> Torngen.Client.Schema.parse({:static, :string}),
      id:
        data
        |> Map.get("id")
        |> Torngen.Client.Schema.parse(Torngen.Client.Schema.FactionBranchId)
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

  defp validate_key?(:upgrades, value) do
    Torngen.Client.Schema.validate?(
      value,
      {:array,
       {:object,
        %{
          "ability" => {:static, :string},
          "challenge" =>
            {:one_of,
             [
               static: :null,
               object: %{
                 "amount_required" => {:static, :integer},
                 "description" => {:static, :string},
                 "stat" => Torngen.Client.Schema.FactionStatEnum
               }
             ]},
          "cost" => {:static, :integer},
          "level" => {:static, :integer},
          "name" => {:static, :string}
        }}}
    )
  end

  defp validate_key?(:name, value) do
    Torngen.Client.Schema.validate?(value, {:static, :string})
  end

  defp validate_key?(:id, value) do
    Torngen.Client.Schema.validate?(value, Torngen.Client.Schema.FactionBranchId)
  end

  @spec keys() :: list(atom())
  def keys(), do: @keys
end
