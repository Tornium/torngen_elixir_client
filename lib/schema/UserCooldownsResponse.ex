defmodule Torngen.Client.Schema.UserCooldownsResponse do
  @moduledoc false

  use Torngen.Client.SchemaObjectAccess, deprecated: []

  @behaviour Torngen.Client.Schema

  @keys [:cooldowns]

  defstruct [
    :cooldowns
  ]

  @type t :: %__MODULE__{
          cooldowns: %{:medical => integer(), :drug => integer(), :booster => integer()}
        }

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      cooldowns:
        data
        |> Map.get("cooldowns")
        |> Torngen.Client.Schema.parse(
          {:object,
           %{
             medical: {:static, :integer},
             drug: {:static, :integer},
             booster: {:static, :integer}
           }}
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

  defp validate_key?(:cooldowns, value) do
    Torngen.Client.Schema.validate?(
      value,
      {:object,
       %{medical: {:static, :integer}, drug: {:static, :integer}, booster: {:static, :integer}}}
    )
  end

  @spec keys() :: list(atom())
  def keys(), do: @keys
end
