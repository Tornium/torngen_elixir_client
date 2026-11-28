defmodule Torngen.Client.Path.Faction.CrimeId.Ochistory do
  @moduledoc """
  Get the history of a specific organized crime.

  Requires limited access key with faction API access permissions. Only available for organized crimes of your current faction. Entries are ordered from newest to oldest, limited to the latest 500. The 'details' field depends on the 'action': * 'Joined', 'Left' & 'Kicked' return 'FactionOcHistoryRoleDetails'. * 'RoleChanged' returns 'FactionOcHistoryRoleChangeDetails'. * 'Spawned' returns 'FactionOcHistorySpawnDetails'. * 'ItemUsed' & 'ItemLost' return 'FactionOcHistoryItem'. * 'Jailed' & 'Hospitalized' return 'FactionOcHistoryPunishmentDetails'. * 'Injured' returns 'FactionOcHistoryInjuryDetails'. * 'Payout' returns 'FactionOcHistoryPayoutDetails'. * 'PayoutReceived' returns 'FactionOcHistoryPayoutReceivedDetails'. * 'Completed', 'Failed' & 'Expired' return null.

  ## Parmeters
  - crimeId: Crime id
  - striptags: Determines if fields include HTML or not ('Hospitalized by <a href=...>user</a>' vs 'Hospitalized by user').
  - timestamp: Timestamp to bypass cache
  - comment: Comment for your tool/service/bot/website to be visible in the logs.
  - key: API key (Limited)

  ## Response Module(s)
  - FactionOcHistoryResponse
  """

  import Torngen.Client.Path, only: [defparameter: 3]

  @behaviour Torngen.Client.Path

  @path "faction/{crimeId}/ochistory"
  @response_modules [FactionOcHistoryResponse]

  Module.register_attribute(__MODULE__, :parameter_keys, accumulate: true)

  @impl true
  def path(), do: @path

  @impl true
  def path_selection(), do: Torngen.Client.Path.path_selection(@path)

  @impl true
  defparameter :crimeId, value do
    # Crime id
    {:path, :crimeId, value}
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
    # API key (Limited). It's not required to use this parameter when passing the API key via the Authorization header.
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
