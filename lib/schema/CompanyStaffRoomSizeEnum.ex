defmodule Torngen.Client.Schema.CompanyStaffRoomSizeEnum do
  @moduledoc false

  require Logger

  @behaviour Torngen.Client.Schema

  @type t :: String.t()

  @values [
    "No staff room",
    "Small staff room",
    "Standard staff room",
    "Large staff room",
    "Very large staff room",
    "Huge staff room",
    "Colossal staff room"
  ]

  @spec values() :: [t()]
  def values, do: @values

  @impl true
  def validate?(value), do: Enum.member?(@values, value)

  @impl true
  def parse(data) do
    if validate?(data) do
      data
    else
      Logger.warning("Invalid enum value #{inspect(data)} of CompanyStaffRoomSizeEnum")
      nil
    end
  end
end
