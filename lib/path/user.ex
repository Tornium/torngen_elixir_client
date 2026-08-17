defmodule Torngen.Client.Path.User do
  @moduledoc """
  Get any User selection.

  Key access level depends on the required selections. Choose one or more selections (comma separated).

  ## Parmeters
  - selections: Selection names
  - id: selection id
  - legacy: Legacy selection names for which you want or expect API v1 response
  - limit: N/A
  - from: Timestamp that sets the lower limit for the data returned
  - to: Timestamp that sets the upper limit for the data returned
  - sort: Sorted by the greatest timestamps
  - cat: Selection category
  - stat: Selection stat
  - filters: It's possible to use this query parameter to only get incoming or outgoing attacks / revives
  - striptags: Determines if fields include HTML or not ('Hospitalized by <a href=...>user</a>' vs 'Hospitalized by user').
  - offset: N/A
  - timestamp: Timestamp to bypass cache
  - comment: Comment for your tool/service/bot/website to be visible in the logs.
  - key: API key (Public)

  ## Response Module(s)
  - TimestampResponse
  - UserInventoryResponse
  - UserLookupResponse
  - UserNewMessagesResponse
  - UserMessagesResponse
  - UserEventsResponse
  - UserNewEventsResponse
  - UserTradesResponse
  - UserTradeResponse
  - UserGymResponse
  - UserBattleStatsResponse
  - UserSkillsResponse
  - UserWorkStatsResponse
  - UserJobPointsResponse
  - UserMoneyResponse
  - UserNetworthResponse
  - UserCasinoResponse
  - AttacksFullResponse
  - UserVirusResponse
  - UserTravelResponse
  - UserRefillsResponse
  - UserPerksResponse
  - UserNotificationsResponse
  - UserCooldownsResponse
  - UserBarsResponse
  - AttacksResponse
  - UserItemModsResponse
  - UserOrganizedCrimeResponse
  - UserPersonalStatsResponse
  - UserMissionsResponse
  - UserEquipmentResponse
  - UserListResponse
  - UserItemMarketResponse
  - UserIconsResponse
  - UserCompetitionResponse
  - UserFactionResponse
  - UserJobResponse
  - UserProfileResponse
  - RevivesFullResponse
  - UserMeritsResponse
  - UserMedalsResponse
  - UserHonorsResponse
  - RevivesResponse
  - UserBasicResponse
  - UserFactionBalanceResponse
  - UserPropertiesResponse
  - UserJobRanksResponse
  - UserBountiesResponse
  - UserStocksResponse
  - UserEducationResponse
  - UserRacingRecordsResponse
  - UserCalendarResponse
  - UserHofResponse
  - ReportsResponse
  - UserPropertyResponse
  - UserForumFriendsResponse
  - UserForumFeedResponse
  - UserForumSubscribedThreadsResponse
  - UserForumThreadsResponse
  - UserForumPostsResponse
  - UserEnlistedCarsResponse
  - UserRacesResponse
  - UserDiscordResponse
  - UserAmmoResponse
  - UserWeaponExpResponse
  - UserCrimesResponse
  """

  import Torngen.Client.Path, only: [defparameter: 3]

  @behaviour Torngen.Client.Path

  @path "user"
  @response_modules [
    TimestampResponse,
    UserInventoryResponse,
    UserLookupResponse,
    UserNewMessagesResponse,
    UserMessagesResponse,
    UserEventsResponse,
    UserNewEventsResponse,
    UserTradesResponse,
    UserTradeResponse,
    UserGymResponse,
    UserBattleStatsResponse,
    UserSkillsResponse,
    UserWorkStatsResponse,
    UserJobPointsResponse,
    UserMoneyResponse,
    UserNetworthResponse,
    UserCasinoResponse,
    AttacksFullResponse,
    UserVirusResponse,
    UserTravelResponse,
    UserRefillsResponse,
    UserPerksResponse,
    UserNotificationsResponse,
    UserCooldownsResponse,
    UserBarsResponse,
    AttacksResponse,
    UserItemModsResponse,
    UserOrganizedCrimeResponse,
    UserPersonalStatsResponse,
    UserMissionsResponse,
    UserEquipmentResponse,
    UserListResponse,
    UserItemMarketResponse,
    UserIconsResponse,
    UserCompetitionResponse,
    UserFactionResponse,
    UserJobResponse,
    UserProfileResponse,
    RevivesFullResponse,
    UserMeritsResponse,
    UserMedalsResponse,
    UserHonorsResponse,
    RevivesResponse,
    UserBasicResponse,
    UserFactionBalanceResponse,
    UserPropertiesResponse,
    UserJobRanksResponse,
    UserBountiesResponse,
    UserStocksResponse,
    UserEducationResponse,
    UserRacingRecordsResponse,
    UserCalendarResponse,
    UserHofResponse,
    ReportsResponse,
    UserPropertyResponse,
    UserForumFriendsResponse,
    UserForumFeedResponse,
    UserForumSubscribedThreadsResponse,
    UserForumThreadsResponse,
    UserForumPostsResponse,
    UserEnlistedCarsResponse,
    UserRacesResponse,
    UserDiscordResponse,
    UserAmmoResponse,
    UserWeaponExpResponse,
    UserCrimesResponse
  ]

  Module.register_attribute(__MODULE__, :parameter_keys, accumulate: true)

  @impl true
  def path(), do: @path

  @impl true
  def path_selection(), do: Torngen.Client.Path.path_selection(@path)

  @impl true
  defparameter :selections, value do
    # Selection names
    {:query, :selections, value}
  end

  @impl true
  defparameter :id, value do
    # selection id
    {:query, :id, value}
  end

  @impl true
  defparameter :legacy, value do
    # Legacy selection names for which you want or expect API v1 response
    {:query, :legacy, value}
  end

  @impl true
  defparameter :limit, value do
    # N/A
    {:query, :limit, value}
  end

  @impl true
  defparameter :from, value do
    # Timestamp that sets the lower limit for the data returned. Data returned will be after this time
    {:query, :from, value}
  end

  @impl true
  defparameter :to, value do
    # Timestamp that sets the upper limit for the data returned. Data returned will be up to and including this time
    {:query, :to, value}
  end

  @impl true
  defparameter :sort, value do
    # Sorted by the greatest timestamps
    {:query, :sort, value}
  end

  @impl true
  defparameter :cat, value do
    # Selection category. Can belong to one of the specified types.
    {:query, :cat, value}
  end

  @impl true
  defparameter :stat, value do
    # Selection stat
    {:query, :stat, value}
  end

  @impl true
  defparameter :filters, value do
    # It's possible to use this query parameter to only get incoming or outgoing attacks / revives. If not specified, this selection will return both incoming and outgoing attacks / revives.
    {:query, :filters, value}
  end

  @impl true
  defparameter :striptags, value do
    # Determines if fields include HTML or not ('Hospitalized by <a href=...>user</a>' vs 'Hospitalized by user').
    {:query, :striptags, value}
  end

  @impl true
  defparameter :offset, value do
    # N/A
    {:query, :offset, value}
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
