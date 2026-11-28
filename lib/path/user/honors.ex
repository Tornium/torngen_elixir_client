defmodule Torngen.Client.Path.User.Honors do
  @moduledoc """
  Get your honors.

  Requires minimal access key. By default (category 'all'), only your achieved honors are returned as 'UserHonorsResponse'. When a specific category is requested, all honors of that category are returned as 'UserHonorsDetailedResponse', including the ones you have not achieved yet. The 'latest' category returns your 36 most recently achieved honors.

  ## Parmeters
  - cat: Honors category, defaults to all
  - timestamp: Timestamp to bypass cache
  - comment: Comment for your tool/service/bot/website to be visible in the logs.
  - key: API key (Minimal)

  ## Response Module(s)
  - UserHonorsDetailedResponse
  - UserHonorsResponse
  """

  import Torngen.Client.Path, only: [defparameter: 3]

  @behaviour Torngen.Client.Path

  @path "user/honors"
  @response_modules [UserHonorsDetailedResponse, UserHonorsResponse]

  Module.register_attribute(__MODULE__, :parameter_keys, accumulate: true)

  @impl true
  def path(), do: @path

  @impl true
  def path_selection(), do: Torngen.Client.Path.path_selection(@path)

  @impl true
  defparameter :cat, value do
    # Honors category, defaults to all
    {:query, :cat, value}
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
    # API key (Minimal). It's not required to use this parameter when passing the API key via the Authorization header.
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
