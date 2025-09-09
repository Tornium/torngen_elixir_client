defmodule Torngen.Client.Schema.UserCompetitionRps do
  @moduledoc false

  use Torngen.Client.SchemaObjectAccess, deprecated: []

  @behaviour Torngen.Client.Schema

  @keys [:status, :name, :hp]

  defstruct [
    :status,
    :name,
    :hp
  ]

  @type t :: %__MODULE__{
          status: Torngen.Client.Schema.UserRpsStatus.t(),
          name: String.t(),
          hp: %{:maximum => integer(), :current => integer()}
        }

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      status:
        data
        |> Map.get("status")
        |> Torngen.Client.Schema.parse(Torngen.Client.Schema.UserRpsStatus),
      name:
        data
        |> Map.get("name")
        |> Torngen.Client.Schema.parse({:enum, :string, ["Rock, Paper, Scissors"]}),
      hp:
        data
        |> Map.get("hp")
        |> Torngen.Client.Schema.parse(
          {:object, %{maximum: {:static, :integer}, current: {:static, :integer}}}
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

  defp validate_key?(:status, value) do
    Torngen.Client.Schema.validate?(value, Torngen.Client.Schema.UserRpsStatus)
  end

  defp validate_key?(:name, value) do
    Torngen.Client.Schema.validate?(value, {:enum, :string, ["Rock, Paper, Scissors"]})
  end

  defp validate_key?(:hp, value) do
    Torngen.Client.Schema.validate?(
      value,
      {:object, %{maximum: {:static, :integer}, current: {:static, :integer}}}
    )
  end

  @spec keys() :: list(atom())
  def keys(), do: @keys
end
