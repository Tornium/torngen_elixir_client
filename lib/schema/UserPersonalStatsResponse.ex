defmodule Torngen.Client.Schema.UserPersonalStatsResponse do
  @moduledoc false

  @behaviour Torngen.Client.Schema

  @type t ::
          Torngen.Client.Schema.UserPersonalStatsHistoric.t()
          | Torngen.Client.Schema.UserPersonalStatsCategory.t()
          | Torngen.Client.Schema.UserPersonalStatsPopular.t()
          | Torngen.Client.Schema.UserPersonalStatsFullPublic.t()
          | Torngen.Client.Schema.UserPersonalStatsFull.t()

  @values [
    UserPersonalStatsHistoric,
    UserPersonalStatsCategory,
    UserPersonalStatsPopular,
    UserPersonalStatsFullPublic,
    UserPersonalStatsFull
  ]

  @spec values() :: [t()]
  def values, do: @values

  @impl true
  def validate?(value) do
    cond do
      Enum.member?(@values, value) ->
        true

      @values
      |> Enum.filter(fn value ->
        is_atom(value) and Code.ensure_loaded?(value) and function_exported?(value, :validate?, 1)
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
      |> Enum.filter(fn value ->
        is_atom(value) and Code.ensure_loaded?(value) and function_exported?(value, :validate?, 1)
      end)
      |> Enum.find(fn mod -> mod.validate?(value) end)
      |> then(&(not is_nil(&1))) ->
        @values
        |> Enum.filter(fn value ->
          is_atom(value) and Code.ensure_loaded?(value) and
            function_exported?(value, :validate?, 1)
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
