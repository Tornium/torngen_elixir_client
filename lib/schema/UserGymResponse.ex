defmodule Torngen.Client.Schema.UserGymResponse do
  @moduledoc false

  use Torngen.Client.SchemaObjectAccess, deprecated: []

  @behaviour Torngen.Client.Schema

  @keys [:gym]

  defstruct [
    :gym
  ]

  @type t :: %__MODULE__{
          gym: %{name: String.t(), id: Torngen.Client.Schema.GymId.t()}
        }

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      gym:
        data
        |> Map.get("gym")
        |> Torngen.Client.Schema.parse(
          {:object, %{id: {:ref, Torngen.Client.Schema.GymId}, name: {:static, :string}}}
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

  defp validate_key?(:gym, value) do
    Torngen.Client.Schema.validate?(
      value,
      {:object, %{id: {:ref, Torngen.Client.Schema.GymId}, name: {:static, :string}}}
    )
  end

  @spec keys() :: list(atom())
  def keys(), do: @keys
end
