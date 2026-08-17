defmodule Torngen.Client.Schema.RequestMetadataWithLinksAndNanostamp do
  @moduledoc false

  use Torngen.Client.SchemaObjectAccess, deprecated: []

  @behaviour Torngen.Client.Schema

  @keys [:nanostamp, :links]

  defstruct [
    :nanostamp,
    :links
  ]

  @type t :: %__MODULE__{
          nanostamp: nil | String.t(),
          links: Torngen.Client.Schema.RequestLinks.t()
        }

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      nanostamp:
        data |> Map.get("nanostamp") |> Torngen.Client.Schema.parse({:one_of, [static: :string]}),
      links:
        data
        |> Map.get("links")
        |> Torngen.Client.Schema.parse({:ref, Torngen.Client.Schema.RequestLinks})
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

  defp validate_key?(:nanostamp, value) do
    Torngen.Client.Schema.validate?(value, {:static, :string})
  end

  defp validate_key?(:links, value) do
    Torngen.Client.Schema.validate?(value, {:ref, Torngen.Client.Schema.RequestLinks})
  end

  @spec keys() :: list(atom())
  def keys(), do: @keys
end
