defmodule Torngen.Client.Schema.UserDiscordResponse do
  @moduledoc false

  use Torngen.Client.SchemaObjectAccess, deprecated: []

  @behaviour Torngen.Client.Schema

  @keys [:discord]

  defstruct [
    :discord
  ]

  @type t :: %__MODULE__{
          discord: %{
            :user_id => Torngen.Client.Schema.UserId.t(),
            :discord_id => Torngen.Client.Schema.DiscordId.t()
          }
        }

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      discord:
        data
        |> Map.get("discord")
        |> Torngen.Client.Schema.parse(
          {:object,
           %{user_id: Torngen.Client.Schema.UserId, discord_id: Torngen.Client.Schema.DiscordId}}
        )
    }
  end

  @impl true
  def parse(_data), do: nil

  @impl true
  def validate?(%{} = data) do
    @keys
    |> Enum.map(fn key -> {key, Map.get(data, Atom.to_string(key))} end)
    |> Enum.map(fn {key, value} -> validate_key?(key, value) end)
    |> Enum.all?()
  end

  defp validate_key?(:discord, value) do
    Torngen.Client.Schema.validate?(
      value,
      {:object,
       %{user_id: Torngen.Client.Schema.UserId, discord_id: Torngen.Client.Schema.DiscordId}}
    )
  end

  @spec keys() :: list(atom())
  def keys(), do: @keys
end
