defmodule Torngen.Client.Schema.TornMedal do
  @moduledoc false

  use Torngen.Client.SchemaObjectAccess, deprecated: []

  @behaviour Torngen.Client.Schema

  @keys [:type, :rarity, :name, :id, :description, :crimes_version, :circulation]

  defstruct [
    :type,
    :rarity,
    :name,
    :id,
    :description,
    :crimes_version,
    :circulation
  ]

  @type t :: %__MODULE__{
          type: %{:title => Torngen.Client.Schema.MedalTypeEnum.t(), :id => String.t()},
          rarity: Torngen.Client.Schema.HonorRarityEnum.t(),
          name: String.t(),
          id: Torngen.Client.Schema.MedalId.t(),
          description: String.t(),
          crimes_version: Torngen.Client.Schema.AwardCrimesVersionEnum.t(),
          circulation: integer()
        }

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      type:
        data
        |> Map.get("type")
        |> Torngen.Client.Schema.parse(
          {:object, %{id: {:static, :string}, title: Torngen.Client.Schema.MedalTypeEnum}}
        ),
      rarity:
        data
        |> Map.get("rarity")
        |> Torngen.Client.Schema.parse(Torngen.Client.Schema.HonorRarityEnum),
      name: data |> Map.get("name") |> Torngen.Client.Schema.parse({:static, :string}),
      id: data |> Map.get("id") |> Torngen.Client.Schema.parse(Torngen.Client.Schema.MedalId),
      description:
        data |> Map.get("description") |> Torngen.Client.Schema.parse({:static, :string}),
      crimes_version:
        data
        |> Map.get("crimes_version")
        |> Torngen.Client.Schema.parse(Torngen.Client.Schema.AwardCrimesVersionEnum),
      circulation:
        data |> Map.get("circulation") |> Torngen.Client.Schema.parse({:static, :integer})
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
    Torngen.Client.Schema.validate?(
      value,
      {:object, %{id: {:static, :string}, title: Torngen.Client.Schema.MedalTypeEnum}}
    )
  end

  defp validate_key?(:rarity, value) do
    Torngen.Client.Schema.validate?(value, Torngen.Client.Schema.HonorRarityEnum)
  end

  defp validate_key?(:name, value) do
    Torngen.Client.Schema.validate?(value, {:static, :string})
  end

  defp validate_key?(:id, value) do
    Torngen.Client.Schema.validate?(value, Torngen.Client.Schema.MedalId)
  end

  defp validate_key?(:description, value) do
    Torngen.Client.Schema.validate?(value, {:static, :string})
  end

  defp validate_key?(:crimes_version, value) do
    Torngen.Client.Schema.validate?(value, Torngen.Client.Schema.AwardCrimesVersionEnum)
  end

  defp validate_key?(:circulation, value) do
    Torngen.Client.Schema.validate?(value, {:static, :integer})
  end

  @spec keys() :: list(atom())
  def keys(), do: @keys
end
