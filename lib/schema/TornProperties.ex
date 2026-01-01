defmodule Torngen.Client.Schema.TornProperties do
  @moduledoc false

  use Torngen.Client.SchemaObjectAccess, deprecated: []

  @behaviour Torngen.Client.Schema

  @keys [:properties]

  defstruct [
    :properties
  ]

  @type t :: %__MODULE__{
          properties:
            nil
            | [
                %{
                  upkeep: integer(),
                  staff: [Torngen.Client.Schema.PropertyStaffEnum.t()],
                  name: String.t(),
                  modifications: [Torngen.Client.Schema.PropertyModificationEnum.t()],
                  id: Torngen.Client.Schema.PropertyTypeId.t(),
                  happy: integer(),
                  cost: integer()
                }
              ]
        }

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      properties:
        data
        |> Map.get("properties")
        |> Torngen.Client.Schema.parse(
          {:one_of,
           [
             static: :null,
             array:
               {:object,
                %{
                  id: {:ref, Torngen.Client.Schema.PropertyTypeId},
                  name: {:static, :string},
                  upkeep: {:static, :integer},
                  modifications: {:array, {:ref, Torngen.Client.Schema.PropertyModificationEnum}},
                  happy: {:static, :integer},
                  cost: {:static, :integer},
                  staff: {:array, {:ref, Torngen.Client.Schema.PropertyStaffEnum}}
                }}
           ]}
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

  defp validate_key?(:properties, value) do
    Torngen.Client.Schema.validate?(
      value,
      {:array,
       {:object,
        %{
          id: {:ref, Torngen.Client.Schema.PropertyTypeId},
          name: {:static, :string},
          upkeep: {:static, :integer},
          modifications: {:array, {:ref, Torngen.Client.Schema.PropertyModificationEnum}},
          happy: {:static, :integer},
          cost: {:static, :integer},
          staff: {:array, {:ref, Torngen.Client.Schema.PropertyStaffEnum}}
        }}}
    )
  end

  @spec keys() :: list(atom())
  def keys(), do: @keys
end
