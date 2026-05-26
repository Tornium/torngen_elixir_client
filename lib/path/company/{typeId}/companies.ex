defmodule Torngen.Client.Path.Company.TypeId.Companies do
  @moduledoc """
  Get a list of companies for a specific company type.

  Requires public access key.

  ## Parmeters
  - typeId: Company type id
  - limit: N/A
  - offset: N/A
  - striptags: Determines if fields include HTML or not ('Hospitalized by <a href=...>user</a>' vs 'Hospitalized by user').
  - timestamp: Timestamp to bypass cache
  - comment: Comment for your tool/service/bot/website to be visible in the logs.
  - key: API key (Public)

  ## Response Module(s)
  - CompaniesResponse
  """

  import Torngen.Client.Path, only: [defparameter: 3]

  @behaviour Torngen.Client.Path

  @path "company/{typeId}/companies"
  @response_modules [CompaniesResponse]

  Module.register_attribute(__MODULE__, :parameter_keys, accumulate: true)

  @impl true
  def path(), do: @path

  @impl true
  def path_selection(), do: Torngen.Client.Path.path_selection(@path)

  @impl true
  defparameter :typeId, value do
    # Company type id
    {:path, :typeId, value}
  end

  @impl true
  defparameter :limit, value do
    # N/A
    {:query, :limit, value}
  end

  @impl true
  defparameter :offset, value do
    # N/A
    {:query, :offset, value}
  end

  @impl true
  defparameter :striptags, value do
    # Determines if fields include HTML or not ('Hospitalized by <a href=...>user</a>' vs 'Hospitalized by user').
    {:query, :striptags, value}
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
