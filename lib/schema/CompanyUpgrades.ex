defmodule Torngen.Client.Schema.CompanyUpgrades do
  @moduledoc false

  use Torngen.Client.SchemaObjectAccess, deprecated: []

  @behaviour Torngen.Client.Schema

  @keys [:storage_capacity, :storage, :staff_room]

  defstruct [
    :storage_capacity,
    :storage,
    :staff_room
  ]

  @type t :: %__MODULE__{
          storage_capacity: Torngen.Client.Schema.CompanyStorageSizeEnum.t(),
          storage: String.t(),
          staff_room: Torngen.Client.Schema.CompanyStaffRoomSizeEnum.t()
        }

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      storage_capacity:
        data
        |> Map.get("storage_capacity")
        |> Torngen.Client.Schema.parse({:ref, Torngen.Client.Schema.CompanyStorageSizeEnum}),
      storage: data |> Map.get("storage") |> Torngen.Client.Schema.parse({:static, :string}),
      staff_room:
        data
        |> Map.get("staff_room")
        |> Torngen.Client.Schema.parse({:ref, Torngen.Client.Schema.CompanyStaffRoomSizeEnum})
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

  defp validate_key?(:storage_capacity, value) do
    Torngen.Client.Schema.validate?(value, {:ref, Torngen.Client.Schema.CompanyStorageSizeEnum})
  end

  defp validate_key?(:storage, value) do
    Torngen.Client.Schema.validate?(value, {:static, :string})
  end

  defp validate_key?(:staff_room, value) do
    Torngen.Client.Schema.validate?(value, {:ref, Torngen.Client.Schema.CompanyStaffRoomSizeEnum})
  end

  @spec keys() :: list(atom())
  def keys(), do: @keys
end
