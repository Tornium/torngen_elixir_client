defmodule Torngen.Client.Schema.UserBar do
  @moduledoc false

  use Torngen.Client.SchemaObjectAccess, deprecated: []

  @behaviour Torngen.Client.Schema

  @keys [:tick_time, :maximum, :interval, :increment, :full_time, :current]

  defstruct [
    :tick_time,
    :maximum,
    :interval,
    :increment,
    :full_time,
    :current
  ]

  @type t :: %__MODULE__{
          tick_time: integer(),
          maximum: integer(),
          interval: integer(),
          increment: integer(),
          full_time: integer(),
          current: integer()
        }

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      tick_time: data |> Map.get("tick_time") |> Torngen.Client.Schema.parse({:static, :integer}),
      maximum: data |> Map.get("maximum") |> Torngen.Client.Schema.parse({:static, :integer}),
      interval: data |> Map.get("interval") |> Torngen.Client.Schema.parse({:static, :integer}),
      increment: data |> Map.get("increment") |> Torngen.Client.Schema.parse({:static, :integer}),
      full_time: data |> Map.get("full_time") |> Torngen.Client.Schema.parse({:static, :integer}),
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

  defp validate_key?(:tick_time, value) do
    Torngen.Client.Schema.validate?(value, {:static, :integer})
  end

  defp validate_key?(:maximum, value) do
    Torngen.Client.Schema.validate?(value, {:static, :integer})
  end

  defp validate_key?(:interval, value) do
    Torngen.Client.Schema.validate?(value, {:static, :integer})
  end

  defp validate_key?(:increment, value) do
    Torngen.Client.Schema.validate?(value, {:static, :integer})
  end

  defp validate_key?(:full_time, value) do
    Torngen.Client.Schema.validate?(value, {:static, :integer})
  end

  defp validate_key?(:current, value) do
    Torngen.Client.Schema.validate?(value, {:static, :integer})
  end

  @spec keys() :: list(atom())
  def keys(), do: @keys
end
