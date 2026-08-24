defmodule Torngen.Client.Path.Torn.Ids.Itemstats do
  @moduledoc """
  Get specific item(s) stats.

  Requires public key.

  ## Parmeters
  - ids: Item uid or a list of item uids (comma separated), 25 uids maximum
  - timestamp: Timestamp to bypass cache
  - comment: Comment for your tool/service/bot/website to be visible in the logs.
  - key: API key (Public)

  ## Response Module(s)
  - TornItemStatsResponse
  """

  import Torngen.Client.Path, only: [defparameter: 3]

  @behaviour Torngen.Client.Path

  @path "torn/{ids}/itemstats"
  @response_modules [TornItemStatsResponse]

  Module.register_attribute(__MODULE__, :parameter_keys, accumulate: true)

  @impl true
  def path(), do: @path

  @impl true
  def path_selection(), do: Torngen.Client.Path.path_selection(@path)

  @impl true
  defparameter :ids, value do
    # Item uid or a list of item uids (comma separated), 25 uids maximum
    {:path, :ids, value}
  end

  @impl true
  defparameter :timestamp, value do
    # Timestamp to bypass cache
    {:query, :timestamp, value}
  end

  @impl true
  defparameter :comment, value do
    # Comment for your tool/service/bot/website to be visible in the logs.
    {:query, :comment, value}
  end

  @impl true
  defparameter :key, value do
    # API key (Public). It's not required to use this parameter when passing the API key via the Authorization header.
    {:query, :key, value}
  end

  @impl true
  def parameter(parameter_name, _value) when is_atom(parameter_name) do
    :error
  end

  @impl true
  def parameters(), do: @parameter_keys

  @impl true
  def response_modules(), do: @response_modules

  @impl true
  def parse(response), do: Torngen.Client.Path.parse(@response_modules, response)

  @impl true
  def moduledoc(), do: @moduledoc
end
