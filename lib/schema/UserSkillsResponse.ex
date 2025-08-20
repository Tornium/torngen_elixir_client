defmodule Torngen.Client.Schema.UserSkillsResponse do
  @moduledoc false

  use Torngen.Client.SchemaObjectAccess, deprecated: []

  @behaviour Torngen.Client.Schema

  @keys [:skills]

  defstruct [
    :skills
  ]

  @type t :: %__MODULE__{
          skills: [Torngen.Client.Schema.UserSkillDetail.t()]
        }

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      skills:
        data
        |> Map.get("skills")
        |> Torngen.Client.Schema.parse({:array, Torngen.Client.Schema.UserSkillDetail})
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

  defp validate_key?(:skills, value) do
    Torngen.Client.Schema.validate?(value, {:array, Torngen.Client.Schema.UserSkillDetail})
  end

  @spec keys() :: list(atom())
  def keys(), do: @keys
end
