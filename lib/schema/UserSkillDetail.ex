defmodule Torngen.Client.Schema.UserSkillDetail do
  @moduledoc false

  use Torngen.Client.SchemaObjectAccess, deprecated: []

  @behaviour Torngen.Client.Schema

  @keys [:slug, :name, :level]

  defstruct [
    :slug,
    :name,
    :level
  ]

  @type t :: %__MODULE__{
          slug: String.t() | Torngen.Client.Schema.UserSkillSlugEnum.t(),
          name: String.t(),
          level: integer() | float()
        }

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      slug:
        data
        |> Map.get("slug")
        |> Torngen.Client.Schema.parse(
          {:one_of, [static: :string, ref: Torngen.Client.Schema.UserSkillSlugEnum]}
        ),
      name: data |> Map.get("name") |> Torngen.Client.Schema.parse({:static, :string}),
      level: data |> Map.get("level") |> Torngen.Client.Schema.parse({:static, :number})
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

  defp validate_key?(:slug, value) do
    Torngen.Client.Schema.validate?(
      value,
      {:one_of, [static: :string, ref: Torngen.Client.Schema.UserSkillSlugEnum]}
    )
  end

  defp validate_key?(:name, value) do
    Torngen.Client.Schema.validate?(value, {:static, :string})
  end

  defp validate_key?(:level, value) do
    Torngen.Client.Schema.validate?(value, {:static, :number})
  end

  @spec keys() :: list(atom())
  def keys(), do: @keys
end
