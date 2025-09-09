defmodule Torngen.Client.Schema.UserMaritalStatusEnum do
  @moduledoc false

  require Logger

  @behaviour Torngen.Client.Schema

  @type t :: String.t()

  @values ["Engaged", "Newlywed", "Married"]

  @spec values() :: [t()]
  def values, do: @values

  @impl true
  def validate?(value), do: Enum.member?(@values, value)

  @impl true
  def parse(data) do
    if validate?(data) do
      data
    else
      Logger.warning("Invalid enum value #{inspect(data)} of UserMaritalStatusEnum")
      nil
    end
  end
end
