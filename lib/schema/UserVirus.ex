defmodule Torngen.Client.Schema.UserVirus do
  @moduledoc false

  use Torngen.Client.SchemaObjectAccess, deprecated: []

  @behaviour Torngen.Client.Schema

  @keys [:until, :item]

  defstruct [
    :until,
    :item
  ]

  @type t :: %__MODULE__{
          until: integer(),
          item: %{:name => String.t(), :id => Torngen.Client.Schema.ItemId.t()}
        }

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      until: data |> Map.get("until") |> Torngen.Client.Schema.parse({:static, :integer}),
      item:
        data
        |> Map.get("item")
        |> Torngen.Client.Schema.parse(
          {:object, %{id: Torngen.Client.Schema.ItemId, name: {:static, :string}}}
        )
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
    Torngen.Client.Schema.validate?(value, {:static, :integer})
  end

  defp validate_key?(:item, value) do
    Torngen.Client.Schema.validate?(
      value,
      {:object, %{id: Torngen.Client.Schema.ItemId, name: {:static, :string}}}
    )
  end

  @spec keys() :: list(atom())
  def keys(), do: @keys
end
