defmodule Torngen.Client.Schema.TornOrganizedCrime do
  @moduledoc false

  use Torngen.Client.SchemaObjectAccess, deprecated: []

  @behaviour Torngen.Client.Schema

  @keys [:spawn, :slots, :scope, :prerequisite, :name, :difficulty, :description]

  defstruct [
    :spawn,
    :slots,
    :scope,
    :prerequisite,
    :name,
    :difficulty,
    :description
  ]

  @type t :: %__MODULE__{
          spawn: Torngen.Client.Schema.TornOrganizedCrimeSpawn.t(),
          slots: [Torngen.Client.Schema.TornOrganizedCrimeSlot.t()],
          scope: Torngen.Client.Schema.TornOrganizedCrimeScope.t(),
          prerequisite: nil | Torngen.Client.Schema.OrganizedCrimeName.t(),
          name: Torngen.Client.Schema.OrganizedCrimeName.t(),
          difficulty: integer(),
          description: String.t()
        }

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      spawn:
        data
        |> Map.get("spawn")
        |> Torngen.Client.Schema.parse({:ref, Torngen.Client.Schema.TornOrganizedCrimeSpawn}),
      slots:
        data
        |> Map.get("slots")
        |> Torngen.Client.Schema.parse(
          {:array, {:ref, Torngen.Client.Schema.TornOrganizedCrimeSlot}}
        ),
      scope:
        data
        |> Map.get("scope")
        |> Torngen.Client.Schema.parse({:ref, Torngen.Client.Schema.TornOrganizedCrimeScope}),
      prerequisite:
        data
        |> Map.get("prerequisite")
        |> Torngen.Client.Schema.parse(
          {:one_of, [static: :null, ref: Torngen.Client.Schema.OrganizedCrimeName]}
        ),
      name:
        data
        |> Map.get("name")
        |> Torngen.Client.Schema.parse({:ref, Torngen.Client.Schema.OrganizedCrimeName}),
      difficulty:
        data |> Map.get("difficulty") |> Torngen.Client.Schema.parse({:static, :integer}),
      description:
        data |> Map.get("description") |> Torngen.Client.Schema.parse({:static, :string})
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

  defp validate_key?(:spawn, value) do
    Torngen.Client.Schema.validate?(value, {:ref, Torngen.Client.Schema.TornOrganizedCrimeSpawn})
  end

  defp validate_key?(:slots, value) do
    Torngen.Client.Schema.validate?(
      value,
      {:array, {:ref, Torngen.Client.Schema.TornOrganizedCrimeSlot}}
    )
  end

  defp validate_key?(:scope, value) do
    Torngen.Client.Schema.validate?(value, {:ref, Torngen.Client.Schema.TornOrganizedCrimeScope})
  end

  defp validate_key?(:prerequisite, value) do
    Torngen.Client.Schema.validate?(
      value,
      {:one_of, [static: :null, ref: Torngen.Client.Schema.OrganizedCrimeName]}
    )
  end

  defp validate_key?(:name, value) do
    Torngen.Client.Schema.validate?(value, {:ref, Torngen.Client.Schema.OrganizedCrimeName})
  end

  defp validate_key?(:difficulty, value) do
    Torngen.Client.Schema.validate?(value, {:static, :integer})
  end

  defp validate_key?(:description, value) do
    Torngen.Client.Schema.validate?(value, {:static, :string})
  end

  @spec keys() :: list(atom())
  def keys(), do: @keys
end
