defmodule Torngen.Client.Schema.Bazaar do
  @moduledoc false

  use Torngen.Client.SchemaObjectAccess, deprecated: []

  @behaviour Torngen.Client.Schema

  @keys [:name, :is_open, :id]

  defstruct [
    :name,
    :is_open,
    :id
  ]

  @type t :: %__MODULE__{
          name: String.t(),
          is_open: boolean(),
          id: Torngen.Client.Schema.UserId.t()
        }

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      name: data |> Map.get("name") |> Torngen.Client.Schema.parse({:static, :string}),
      is_open: data |> Map.get("is_open") |> Torngen.Client.Schema.parse({:static, :boolean}),
      id: data |> Map.get("id") |> Torngen.Client.Schema.parse(Torngen.Client.Schema.UserId)
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

  defp validate_key?(:is_open, value) do
    Torngen.Client.Schema.validate?(value, {:static, :boolean})
  end

  defp validate_key?(:id, value) do
    Torngen.Client.Schema.validate?(value, Torngen.Client.Schema.UserId)
  end

  @spec keys() :: list(atom())
  def keys(), do: @keys
end
