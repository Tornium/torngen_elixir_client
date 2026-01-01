defmodule Torngen.Client.Schema.UserBasicResponse do
  @moduledoc false

  use Torngen.Client.SchemaObjectAccess, deprecated: []

  @behaviour Torngen.Client.Schema

  @keys [:profile]

  defstruct [
    :profile
  ]

  @type t :: %__MODULE__{
          profile: Torngen.Client.Schema.UserBasic.t()
        }

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      profile:
        data
        |> Map.get("profile")
        |> Torngen.Client.Schema.parse({:ref, Torngen.Client.Schema.UserBasic})
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

  defp validate_key?(:profile, value) do
    Torngen.Client.Schema.validate?(value, {:ref, Torngen.Client.Schema.UserBasic})
  end

  @spec keys() :: list(atom())
  def keys(), do: @keys
end
