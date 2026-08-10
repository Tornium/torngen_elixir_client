defmodule Torngen.Client.Path.User.Log do
  @moduledoc """
  Get your logs.

  Requires full access key. It's possible to pass a list of log ids or a log category id. This selection is standalone and cannot be used together with other selections.

  ## Parmeters
  - log: Log ids, comma separated, e.g
  - cat: Log category id
  - target: Get logs where you interacted with a specific player by passing their player ID.
  - limit: N/A
  - to: Timestamp that sets the upper limit for the data returned
  - from: Timestamp that sets the lower limit for the data returned
  - timestamp: Timestamp to bypass cache
  - comment: Comment for your tool/service/bot/website to be visible in the logs.
  - key: API key (Full)

  ## Response Module(s)
  - UserLogsResponse
  """

  import Torngen.Client.Path, only: [defparameter: 3]

  @behaviour Torngen.Client.Path

  @path "user/log"
  @response_modules [UserLogsResponse]

  Module.register_attribute(__MODULE__, :parameter_keys, accumulate: true)

  @impl true
  def path(), do: @path

  @impl true
  def path_selection(), do: Torngen.Client.Path.path_selection(@path)

  @impl true
  defparameter :log, value do
    # Log ids, comma separated, e.g. 105,4900,4905
    {:query, :log, value}
  end

  @impl true
  defparameter :cat, value do
    # Log category id
    {:query, :cat, value}
  end

  @impl true
  defparameter :target, value do
    # Get logs where you interacted with a specific player by passing their player ID.
    {:query, :target, value}
  end

  @impl true
  defparameter :limit, value do
    # N/A
    {:query, :limit, value}
  end

  @impl true
  defparameter :to, value do
    # Timestamp that sets the upper limit for the data returned. Data returned will be up to and including this time
    {:query, :to, value}
  end

  @impl true
  defparameter :from, value do
    # Timestamp that sets the lower limit for the data returned. Data returned will be after this time
    {:query, :from, value}
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
    # API key (Full). It's not required to use this parameter when passing the API key via the Authorization header.
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
