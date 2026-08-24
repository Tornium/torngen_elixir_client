defmodule Torngen.Client.Schema.ApiError do
  @moduledoc false

  @behaviour Torngen.Client.Schema

  @type t ::
          Torngen.Client.Schema.ErrorCityStatsCronFailed.t()
          | Torngen.Client.Schema.ErrorFileDoesNotExist.t()
          | Torngen.Client.Schema.ErrorCategorySelectionUnavailableForInteractionLogs.t()
          | Torngen.Client.Schema.ErrorIncorrectLogId.t()
          | Torngen.Client.Schema.ErrorMustMigrateToOrganizedCrimesV2.t()
          | Torngen.Client.Schema.ErrorOnlyCategoryOrStatsAllowed.t()
          | Torngen.Client.Schema.ErrorInvalidStatRequested.t()
          | Torngen.Client.Schema.ErrorClosedTemporarily.t()
          | Torngen.Client.Schema.ErrorOnlyAvailableInApiV2.t()
          | Torngen.Client.Schema.ErrorOnlyAvailableInApiV1.t()
          | Torngen.Client.Schema.ErrorIncorrectCategory.t()
          | Torngen.Client.Schema.ErrorRaceNotFinished.t()
          | Torngen.Client.Schema.ErrorMustMigrateToCrimesV2.t()
          | Torngen.Client.Schema.ErrorApiKeyPaused.t()
          | Torngen.Client.Schema.ErrorBackendError.t()
          | Torngen.Client.Schema.ErrorAccessLevelTooLow.t()
          | Torngen.Client.Schema.ErrorLogUnavailable.t()
          | Torngen.Client.Schema.ErrorDailyReadLimitReached.t()
          | Torngen.Client.Schema.ErrorKeyTemporaryDisabled.t()
          | Torngen.Client.Schema.ErrorKeyReadError.t()
          | Torngen.Client.Schema.ErrorKeyChangeCooldown.t()
          | Torngen.Client.Schema.ErrorKeyOwnerInFederalJail.t()
          | Torngen.Client.Schema.ErrorApiDisabled.t()
          | Torngen.Client.Schema.ErrorIpBlocked.t()
          | Torngen.Client.Schema.ErrorIncorrectIdEntityRelation.t()
          | Torngen.Client.Schema.ErrorIncorrectId.t()
          | Torngen.Client.Schema.ErrorTooManyRequests.t()
          | Torngen.Client.Schema.ErrorWrongFields.t()
          | Torngen.Client.Schema.ErrorWrongType.t()
          | Torngen.Client.Schema.ErrorIncorrectKey.t()
          | Torngen.Client.Schema.ErrorKeyEmpty.t()
          | Torngen.Client.Schema.ErrorUnknown.t()

  @values [
    ErrorCityStatsCronFailed,
    ErrorFileDoesNotExist,
    ErrorCategorySelectionUnavailableForInteractionLogs,
    ErrorIncorrectLogId,
    ErrorMustMigrateToOrganizedCrimesV2,
    ErrorOnlyCategoryOrStatsAllowed,
    ErrorInvalidStatRequested,
    ErrorClosedTemporarily,
    ErrorOnlyAvailableInApiV2,
    ErrorOnlyAvailableInApiV1,
    ErrorIncorrectCategory,
    ErrorRaceNotFinished,
    ErrorMustMigrateToCrimesV2,
    ErrorApiKeyPaused,
    ErrorBackendError,
    ErrorAccessLevelTooLow,
    ErrorLogUnavailable,
    ErrorDailyReadLimitReached,
    ErrorKeyTemporaryDisabled,
    ErrorKeyReadError,
    ErrorKeyChangeCooldown,
    ErrorKeyOwnerInFederalJail,
    ErrorApiDisabled,
    ErrorIpBlocked,
    ErrorIncorrectIdEntityRelation,
    ErrorIncorrectId,
    ErrorTooManyRequests,
    ErrorWrongFields,
    ErrorWrongType,
    ErrorIncorrectKey,
    ErrorKeyEmpty,
    ErrorUnknown
  ]

  @spec values() :: [t()]
  def values, do: @values

  @impl true
  def validate?(value) do
    cond do
      Enum.member?(@values, value) ->
        true

      @values
      |> Enum.filter(&is_atom/1)
      |> Enum.map(fn value -> Module.concat(Torngen.Client.Schema, value) end)
      |> Enum.filter(fn value ->
        Code.ensure_loaded?(value) and function_exported?(value, :validate?, 1)
      end)
      |> Enum.find(false, fn mod -> mod.validate?(value) end) ->
        true

      true ->
        (Enum.member?(@values, :string) and is_binary(value)) or
          (Enum.member?(@values, :number) and is_number(value)) or
          (Enum.member?(@values, :integer) and is_integer(value)) or
          (Enum.member?(@values, :boolean) and is_boolean(value))
    end
  end

  @impl true
  def parse(value) do
    cond do
      Enum.member?(@values, value) ->
        true

      @values
      |> Enum.filter(&is_atom/1)
      |> Enum.map(fn value -> Module.concat(Torngen.Client.Schema, value) end)
      |> Enum.filter(fn value ->
        Code.ensure_loaded?(value) and function_exported?(value, :validate?, 1)
      end)
      |> Enum.find(fn mod -> mod.validate?(value) end)
      |> then(&(not is_nil(&1))) ->
        @values
        |> Enum.filter(&is_atom/1)
        |> Enum.map(fn value -> Module.concat(Torngen.Client.Schema, value) end)
        |> Enum.filter(fn value ->
          Code.ensure_loaded?(value) and function_exported?(value, :validate?, 1)
        end)
        |> Enum.find(fn mod -> mod.validate?(value) end)
        |> apply(:parse, [value])

      Enum.member?(@values, :string) and is_binary(value) ->
        value

      Enum.member?(@values, :number) and is_number(value) ->
        value

      Enum.member?(@values, :integer) and is_integer(value) ->
        value

      Enum.member?(@values, :boolean) and is_boolean(value) ->
        value

      true ->
        nil
    end
  end
end
