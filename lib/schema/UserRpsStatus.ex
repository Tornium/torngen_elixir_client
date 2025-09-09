defmodule Torngen.Client.Schema.UserRpsStatus do
  @moduledoc false

  require Logger

  @behaviour Torngen.Client.Schema

  @type t :: String.t()

  @values ["scissors", "rock", "paper"]

  @spec values() :: [t()]
  def values, do: @values

  @impl true
  def validate?(value), do: Enum.member?(@values, value)

  @impl true
  def parse(data) do
    if validate?(data) do
      data
    else
      Logger.warning("Invalid enum value #{inspect(data)} of UserRpsStatus")
      nil
    end
  end
end
