defmodule Torngen.Client.Schema.UserNotificationsResponse do
  @moduledoc false

  use Torngen.Client.SchemaObjectAccess, deprecated: []

  @behaviour Torngen.Client.Schema

  @keys [:notifications]

  defstruct [
    :notifications
  ]

  @type t :: %__MODULE__{
          notifications: %{
            messages: integer(),
            events: integer(),
            competition: integer(),
            awards: integer()
          }
        }

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      notifications:
        data
        |> Map.get("notifications")
        |> Torngen.Client.Schema.parse(
          {:object,
           %{
             messages: {:static, :integer},
             events: {:static, :integer},
             awards: {:static, :integer},
             competition: {:static, :integer}
           }}
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

  defp validate_key?(:notifications, value) do
    Torngen.Client.Schema.validate?(
      value,
      {:object,
       %{
         messages: {:static, :integer},
         events: {:static, :integer},
         awards: {:static, :integer},
         competition: {:static, :integer}
       }}
    )
  end

  @spec keys() :: list(atom())
  def keys(), do: @keys
end
