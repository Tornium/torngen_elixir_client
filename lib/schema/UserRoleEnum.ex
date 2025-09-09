defmodule Torngen.Client.Schema.UserRoleEnum do
  @moduledoc false

  require Logger

  @behaviour Torngen.Client.Schema

  @type t :: String.t()

  @values [
    "Admin",
    "Officer",
    "Moderator",
    "Helper",
    "Tester",
    "NPC",
    "Committee",
    "Reporter",
    "Wiki Contributor",
    "Wiki Editor",
    "Civilian"
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
      Logger.warning("Invalid enum value #{inspect(data)} of UserRoleEnum")
      nil
    end
  end
end
