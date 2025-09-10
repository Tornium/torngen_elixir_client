defmodule Torngen.Client.Schema.UserStatus do
  @moduledoc false

  use Torngen.Client.SchemaObjectAccess, deprecated: []

  @behaviour Torngen.Client.Schema

  @keys [:until, :travel_type, :state, :details, :description, :color]

  defstruct [
    :until,
    :travel_type,
    :state,
    :details,
    :description,
    :color
  ]

  @type t :: %__MODULE__{
          until: nil | integer(),
          travel_type: String.t(),
          state: String.t(),
          details: nil | String.t(),
          description: String.t(),
          color: String.t()
        }

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      until:
        data
        |> Map.get("until")
        |> Torngen.Client.Schema.parse({:one_of, [static: :null, static: :integer]}),
      travel_type:
        data |> Map.get("travel_type") |> Torngen.Client.Schema.parse({:static, :string}),
      state: data |> Map.get("state") |> Torngen.Client.Schema.parse({:static, :string}),
      details:
        data
        |> Map.get("details")
        |> Torngen.Client.Schema.parse({:one_of, [static: :null, static: :string]}),
      description:
        data |> Map.get("description") |> Torngen.Client.Schema.parse({:static, :string}),
      color: data |> Map.get("color") |> Torngen.Client.Schema.parse({:static, :string})
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

  defp validate_key?(:until, value) do
    Torngen.Client.Schema.validate?(value, {:one_of, [static: :null, static: :integer]})
  end

  defp validate_key?(:travel_type, value) do
    Torngen.Client.Schema.validate?(value, {:static, :string})
  end

  defp validate_key?(:state, value) do
    Torngen.Client.Schema.validate?(value, {:static, :string})
  end

  defp validate_key?(:details, value) do
    Torngen.Client.Schema.validate?(value, {:one_of, [static: :null, static: :string]})
  end

  defp validate_key?(:description, value) do
    Torngen.Client.Schema.validate?(value, {:static, :string})
  end

  defp validate_key?(:color, value) do
    Torngen.Client.Schema.validate?(value, {:static, :string})
  end

  @spec keys() :: list(atom())
  def keys(), do: @keys
end
