defmodule Torngen.Client.Schema.FactionApplication do
  @moduledoc false

  use Torngen.Client.SchemaObjectAccess, deprecated: []

  @behaviour Torngen.Client.Schema

  @keys [:valid_until, :user, :status, :message, :id]

  defstruct [
    :valid_until,
    :user,
    :status,
    :message,
    :id
  ]

  @type t :: %__MODULE__{
          valid_until: integer(),
          user: %{
            :stats =>
              nil
              | %{
                  :strength => integer(),
                  :speed => integer(),
                  :dexterity => integer(),
                  :defense => integer()
                },
            :name => String.t(),
            :level => integer(),
            :id => Torngen.Client.Schema.UserId.t()
          },
          status: Torngen.Client.Schema.FactionApplicationStatusEnum.t(),
          message: nil | String.t(),
          id: integer()
        }

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      valid_until:
        data |> Map.get("valid_until") |> Torngen.Client.Schema.parse({:static, :integer}),
      user:
        data
        |> Map.get("user")
        |> Torngen.Client.Schema.parse(
          {:object,
           %{
             id: Torngen.Client.Schema.UserId,
             name: {:static, :string},
             level: {:static, :integer},
             stats:
               {:one_of,
                [
                  static: :null,
                  object: %{
                    speed: {:static, :integer},
                    strength: {:static, :integer},
                    dexterity: {:static, :integer},
                    defense: {:static, :integer}
                  }
                ]}
           }}
        ),
      status:
        data
        |> Map.get("status")
        |> Torngen.Client.Schema.parse(Torngen.Client.Schema.FactionApplicationStatusEnum),
      message:
        data
        |> Map.get("message")
        |> Torngen.Client.Schema.parse({:one_of, [static: :null, static: :string]}),
      id: data |> Map.get("id") |> Torngen.Client.Schema.parse({:static, :integer})
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

  defp validate_key?(:valid_until, value) do
    Torngen.Client.Schema.validate?(value, {:static, :integer})
  end

  defp validate_key?(:user, value) do
    Torngen.Client.Schema.validate?(
      value,
      {:object,
       %{
         id: Torngen.Client.Schema.UserId,
         name: {:static, :string},
         level: {:static, :integer},
         stats:
           {:one_of,
            [
              static: :null,
              object: %{
                speed: {:static, :integer},
                strength: {:static, :integer},
                dexterity: {:static, :integer},
                defense: {:static, :integer}
              }
            ]}
       }}
    )
  end

  defp validate_key?(:status, value) do
    Torngen.Client.Schema.validate?(value, Torngen.Client.Schema.FactionApplicationStatusEnum)
  end

  defp validate_key?(:message, value) do
    Torngen.Client.Schema.validate?(value, {:one_of, [static: :null, static: :string]})
  end

  defp validate_key?(:id, value) do
    Torngen.Client.Schema.validate?(value, {:static, :integer})
  end

  @spec keys() :: list(atom())
  def keys(), do: @keys
end
