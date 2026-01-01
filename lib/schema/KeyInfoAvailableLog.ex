defmodule Torngen.Client.Schema.KeyInfoAvailableLog do
  @moduledoc false

  use Torngen.Client.SchemaObjectAccess, deprecated: []

  @behaviour Torngen.Client.Schema

  @keys [:log_ids, :category_id]

  defstruct [
    :log_ids,
    :category_id
  ]

  @type t :: %__MODULE__{
          log_ids: [Torngen.Client.Schema.LogId.t()],
          category_id: Torngen.Client.Schema.LogCategoryId.t()
        }

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      log_ids:
        data
        |> Map.get("log_ids")
        |> Torngen.Client.Schema.parse({:array, {:ref, Torngen.Client.Schema.LogId}}),
      category_id:
        data
        |> Map.get("category_id")
        |> Torngen.Client.Schema.parse({:ref, Torngen.Client.Schema.LogCategoryId})
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

  defp validate_key?(:log_ids, value) do
    Torngen.Client.Schema.validate?(value, {:array, {:ref, Torngen.Client.Schema.LogId}})
  end

  defp validate_key?(:category_id, value) do
    Torngen.Client.Schema.validate?(value, {:ref, Torngen.Client.Schema.LogCategoryId})
  end

  @spec keys() :: list(atom())
  def keys(), do: @keys
end
