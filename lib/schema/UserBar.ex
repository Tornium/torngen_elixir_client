defmodule Torngen.Client.Schema.UserBar do
  @moduledoc false

  use Torngen.Client.SchemaObjectAccess, deprecated: []

  @behaviour Torngen.Client.Schema

  @keys [:maximum, :current]

  defstruct [
    :maximum,
    :current
  ]

  @type t :: %__MODULE__{
          maximum: integer(),
          current: integer()
        }

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      maximum: data |> Map.get("maximum") |> Torngen.Client.Schema.parse({:static, :integer}),
      current: data |> Map.get("current") |> Torngen.Client.Schema.parse({:static, :integer})
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

  defp validate_key?(:maximum, value) do
    Torngen.Client.Schema.validate?(value, {:static, :integer})
  end

  defp validate_key?(:current, value) do
    Torngen.Client.Schema.validate?(value, {:static, :integer})
  end

  @spec keys() :: list(atom())
  def keys(), do: @keys
end
