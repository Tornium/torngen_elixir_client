defmodule Torngen.Client.Schema.UserIconsResponse do
  @moduledoc false

  use Torngen.Client.SchemaObjectAccess, deprecated: []

  @behaviour Torngen.Client.Schema

  @keys [:icons]

  defstruct [
    :icons
  ]

  @type t :: %__MODULE__{
          icons:
            [Torngen.Client.Schema.UserIconPublic.t()]
            | [Torngen.Client.Schema.UserIconPrivate.t()]
        }

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      icons:
        data
        |> Map.get("icons")
        |> Torngen.Client.Schema.parse(
          {:one_of,
           [
             array: Torngen.Client.Schema.UserIconPublic,
             array: Torngen.Client.Schema.UserIconPrivate
           ]}
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

  defp validate_key?(:icons, value) do
    Torngen.Client.Schema.validate?(
      value,
      {:one_of,
       [array: Torngen.Client.Schema.UserIconPublic, array: Torngen.Client.Schema.UserIconPrivate]}
    )
  end

  @spec keys() :: list(atom())
  def keys(), do: @keys
end
