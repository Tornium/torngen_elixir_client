defmodule Torngen.Client.Schema.UserJob do
  @moduledoc false

  use Torngen.Client.SchemaObjectAccess, deprecated: []

  @behaviour Torngen.Client.Schema

  @keys [:type, :position, :name]

  defstruct [
    :type,
    :position,
    :name
  ]

  @type t :: %__MODULE__{
          type: String.t(),
          position:
            Torngen.Client.Schema.JobPositionEducationEnum.t()
            | Torngen.Client.Schema.JobPositionLawEnum.t()
            | Torngen.Client.Schema.JobPositionMedicalEnum.t()
            | Torngen.Client.Schema.JobPositionCasinoEnum.t()
            | Torngen.Client.Schema.JobPositionGrocerEnum.t()
            | Torngen.Client.Schema.JobPositionArmyEnum.t(),
          name: Torngen.Client.Schema.JobTypeEnum.t()
        }

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      type: data |> Map.get("type") |> Torngen.Client.Schema.parse({:enum, :string, ["job"]}),
      position:
        data
        |> Map.get("position")
        |> Torngen.Client.Schema.parse(
          {:one_of,
           [
             Torngen.Client.Schema.JobPositionEducationEnum,
             Torngen.Client.Schema.JobPositionLawEnum,
             Torngen.Client.Schema.JobPositionMedicalEnum,
             Torngen.Client.Schema.JobPositionCasinoEnum,
             Torngen.Client.Schema.JobPositionGrocerEnum,
             Torngen.Client.Schema.JobPositionArmyEnum
           ]}
        ),
      name:
        data |> Map.get("name") |> Torngen.Client.Schema.parse(Torngen.Client.Schema.JobTypeEnum)
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

  defp validate_key?(:type, value) do
    Torngen.Client.Schema.validate?(value, {:enum, :string, ["job"]})
  end

  defp validate_key?(:position, value) do
    Torngen.Client.Schema.validate?(
      value,
      {:one_of,
       [
         Torngen.Client.Schema.JobPositionEducationEnum,
         Torngen.Client.Schema.JobPositionLawEnum,
         Torngen.Client.Schema.JobPositionMedicalEnum,
         Torngen.Client.Schema.JobPositionCasinoEnum,
         Torngen.Client.Schema.JobPositionGrocerEnum,
         Torngen.Client.Schema.JobPositionArmyEnum
       ]}
    )
  end

  defp validate_key?(:name, value) do
    Torngen.Client.Schema.validate?(value, Torngen.Client.Schema.JobTypeEnum)
  end

  @spec keys() :: list(atom())
  def keys(), do: @keys
end
