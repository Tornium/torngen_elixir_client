defmodule Torngen.Client.Schema.ErrorWrongFields do
  @moduledoc false

  use Torngen.Client.SchemaObjectAccess, deprecated: []

  @behaviour Torngen.Client.Schema

  @keys [:error, :code]

  defstruct [
    :error,
    :code
  ]

  @type t :: %__MODULE__{
          error: String.t(),
          code: 4
        }

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      error: data |> Map.get("error") |> Torngen.Client.Schema.parse({:static, :string}),
      code: data |> Map.get("code") |> Torngen.Client.Schema.parse({:enum, :integer, [4]})
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

  defp validate_key?(:error, value) do
    Torngen.Client.Schema.validate?(value, {:static, :string})
  end

  defp validate_key?(:code, value) do
    Torngen.Client.Schema.validate?(value, {:enum, :integer, [4]})
  end

  @spec keys() :: list(atom())
  def keys(), do: @keys
end
