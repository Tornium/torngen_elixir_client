defmodule Torngen.Client.Schema.JobTypeEnum do
  @moduledoc false

  require Logger

  @behaviour Torngen.Client.Schema

  @type t :: String.t()

  @values ["Army", "Casino", "Education", "Grocer", "Law", "Medical"]

  @spec values() :: [t()]
  def values, do: @values

  @impl true
  def validate?(value), do: Enum.member?(@values, value)

  @impl true
  def parse(data) do
    if validate?(data) do
      data
    else
      Logger.warning("Invalid enum value #{inspect(data)} of JobTypeEnum")
      nil
    end
  end
end
