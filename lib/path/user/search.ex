defmodule Torngen.Client.Path.User.Search do
  @moduledoc """
  Search users by name or other criteria.

  Requires public access key. This selection is standalone and cannot be used together with other selections. It's always limited to return just 25 records.

  ## Parmeters
  - name: Name to search for.
  - filters: A filtering query parameter allowing a comma-separated list of filters
  - offset: N/A
  - timestamp: Timestamp to bypass cache
  - comment: Comment for your tool/service/bot/website to be visible in the logs.
  - key: API key (Public)

  ## Response Module(s)
  - UserSearchResponse
  """

  import Torngen.Client.Path, only: [defparameter: 3]

  @behaviour Torngen.Client.Path

  @path "user/search"
  @response_modules [UserSearchResponse]

  Module.register_attribute(__MODULE__, :parameter_keys, accumulate: true)

  @impl true
  def path(), do: @path

  @impl true
  def path_selection(), do: Torngen.Client.Path.path_selection(@path)

  @impl true
  defparameter :name, value do
    # Name to search for.
    {:query, :name, value}
  end

  @impl true
  defparameter :filters, value do
    # A filtering query parameter allowing a comma-separated list of filters.    *  Filters in this selection reflect on-site filters, and they can be:  *  One of: `married`, `notMarried`, `traveling`, `notTraveling`, `inFaction`, `notInFaction`, `inCompany`, `notInCompany`, `inHospital`, `notInHospital`, `inJail`, `notInJail`, `inFederalJail`, `notInFederalJail`  *  Additionally, one of last action: `lastActionNow`, `lastActionRecent`, `lastActionHourAgo`, `lastActionDayAgo`, `lastActionWeekAgo`, `lastActionMonthAgo`, `lastActionYearAgo`  *  Additionally, one of gender: `male`, `female`, `enby`  *  Any dynamic option: `fieldName`+`condition`+`number`. Each dynamic filter is made out of 3 parts separated by colon `:`:  *  * `fieldName` is one of: `level`, `daysOld`, `offences`  *  * `condition` is one of: `=`, `!=`, `<`, `<=`, `>=`, `>`, `Equal`, `NotEqual`, `Less`, `LessOrEqual`, `GreaterOrEqual`, `Greater`  *  * `number`: any integer value  *  Additionally, a dynamic list of faction ids (negates `inFaction` and `notInFaction` filters): `factions`+`:`+`list of ids separated by semicolon ;`  *  Examples:  * `filters=married`,  * `filters=daysOld:>=:5000,offences:>:100000,notInFaction`,  * `filters=factions:1;2;3`,  * `filters=level:=:100,lastActionYearAgo,male,inFaction,offences:>=:1000,offences:<=:1000000,daysOld:>:500,daysOld:<:7000`
    {:query, :filters, value}
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
