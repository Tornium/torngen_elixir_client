defmodule Torngen.Client.Schema.FactionOcHistoryRoleChangeDetails do
  @moduledoc false

  use Torngen.Client.SchemaObjectAccess, deprecated: []

  @behaviour Torngen.Client.Schema

  @keys [:old_role, :new_role]

  defstruct [
    :old_role,
    :new_role
  ]

  @type t :: %__MODULE__{
          old_role: Torngen.Client.Schema.FactionOcHistoryRole.t(),
          new_role: Torngen.Client.Schema.FactionOcHistoryRole.t()
        }

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      old_role:
        data
        |> Map.get("old_role")
        |> Torngen.Client.Schema.parse({:ref, Torngen.Client.Schema.FactionOcHistoryRole}),
      new_role:
        data
        |> Map.get("new_role")
        |> Torngen.Client.Schema.parse({:ref, Torngen.Client.Schema.FactionOcHistoryRole})
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

  defp validate_key?(:old_role, value) do
    Torngen.Client.Schema.validate?(value, {:ref, Torngen.Client.Schema.FactionOcHistoryRole})
  end

  defp validate_key?(:new_role, value) do
    Torngen.Client.Schema.validate?(value, {:ref, Torngen.Client.Schema.FactionOcHistoryRole})
  end

  @spec keys() :: list(atom())
  def keys(), do: @keys
end
