defmodule Torngen.Client.Schema.TornRankedWarTemplateEntry do
  @moduledoc false

  use Torngen.Client.SchemaObjectAccess, deprecated: []

  @behaviour Torngen.Client.Schema

  @keys [:name, :description]

  defstruct [
    :name,
    :description
  ]

  @type t :: %__MODULE__{
          name: String.t(),
          description: nil | String.t()
        }

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      name: data |> Map.get("name") |> Torngen.Client.Schema.parse({:static, :string}),
      description:
        data
        |> Map.get("description")
        |> Torngen.Client.Schema.parse({:one_of, [static: :null, static: :string]})
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

  defp validate_key?(:description, value) do
    Torngen.Client.Schema.validate?(value, {:one_of, [static: :null, static: :string]})
  end

  @spec keys() :: list(atom())
  def keys(), do: @keys
end
