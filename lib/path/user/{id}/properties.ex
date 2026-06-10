defmodule Torngen.Client.Path.User.Id.Properties do
  @moduledoc """
  Get specific user's properties.

  Requires public access key. Extended responses are available when requesting the data with Limited or higher access keys for yourself or your spouse.

  ## Parmeters
  - id: User id or user discord id
  - filters: It's possible to use this query parameter to filter properties by the key owner or their spouse.
  - offset: N/A
  - limit: N/A
  - timestamp: Timestamp to bypass cache or get the data in specific point in time
  - comment: Comment for your tool/service/bot/website to be visible in the logs.
  - key: API key (Public)

  ## Response Module(s)
  - UserPropertiesResponse
  """

  import Torngen.Client.Path, only: [defparameter: 3]

  @behaviour Torngen.Client.Path

  @path "user/{id}/properties"
  @response_modules [UserPropertiesResponse]

  Module.register_attribute(__MODULE__, :parameter_keys, accumulate: true)

  @impl true
  def path(), do: @path

  @impl true
  def path_selection(), do: Torngen.Client.Path.path_selection(@path)

  @impl true
  defparameter :id, value do
    # User id or user discord id
    {:path, :id, value}
  end

  @impl true
  defparameter :filters, value do
    # It's possible to use this query parameter to filter properties by the key owner or their spouse.
    {:query, :filters, value}
  end

  @impl true
  defparameter :offset, value do
    # N/A
    {:query, :offset, value}
  end

  @impl true
  defparameter :limit, value do
    # N/A
    {:query, :limit, value}
  end

  @impl true
  defparameter :timestamp, value do
    # Timestamp to bypass cache or get the data in specific point in time
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
