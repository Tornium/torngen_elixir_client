defmodule Torngen.Client.Schema.UserProfileResponse do
  @moduledoc false

  use Torngen.Client.SchemaObjectAccess, deprecated: []

  @behaviour Torngen.Client.Schema

  @keys [:profile]

  defstruct [
    :profile
  ]

  @type t :: %__MODULE__{
          profile: %{
            title: String.t() | Torngen.Client.Schema.UserTitleEnum.t(),
            status: Torngen.Client.Schema.UserStatus.t(),
            spouse: nil | Torngen.Client.Schema.ProfileSpouse.t(),
            signed_up: integer(),
            role: Torngen.Client.Schema.UserRoleEnum.t(),
            revive_setting: Torngen.Client.Schema.ReviveSetting.t(),
            revivable: boolean(),
            rank: String.t() | Torngen.Client.Schema.UserRankEnum.t(),
            property: %{name: String.t(), id: Torngen.Client.Schema.PropertyId.t()},
            name: String.t(),
            life: %{maximum: integer(), current: integer()},
            level: integer(),
            last_action: Torngen.Client.Schema.UserLastAction.t(),
            karma: integer(),
            image: nil | String.t(),
            id: Torngen.Client.Schema.UserId.t(),
            honor_id: Torngen.Client.Schema.HonorId.t(),
            gender: Torngen.Client.Schema.UserGenderEnum.t(),
            friends: integer(),
            forum_posts: integer(),
            faction_id: nil | Torngen.Client.Schema.FactionId.t(),
            enemies: integer(),
            donator_status: nil | Torngen.Client.Schema.UserDonatorStatusEnum.t(),
            awards: integer(),
            age: integer()
          }
        }

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      profile:
        data
        |> Map.get("profile")
        |> Torngen.Client.Schema.parse(
          {:object,
           %{
             id: {:ref, Torngen.Client.Schema.UserId},
             name: {:static, :string},
             status: {:ref, Torngen.Client.Schema.UserStatus},
             level: {:static, :integer},
             title: {:one_of, [static: :string, ref: Torngen.Client.Schema.UserTitleEnum]},
             property:
               {:object,
                %{id: {:ref, Torngen.Client.Schema.PropertyId}, name: {:static, :string}}},
             image: {:one_of, [static: :null, static: :string]},
             role: {:ref, Torngen.Client.Schema.UserRoleEnum},
             awards: {:static, :integer},
             last_action: {:ref, Torngen.Client.Schema.UserLastAction},
             life: {:object, %{maximum: {:static, :integer}, current: {:static, :integer}}},
             signed_up: {:static, :integer},
             rank: {:one_of, [static: :string, ref: Torngen.Client.Schema.UserRankEnum]},
             faction_id: {:one_of, [static: :null, ref: Torngen.Client.Schema.FactionId]},
             spouse: {:one_of, [static: :null, ref: Torngen.Client.Schema.ProfileSpouse]},
             friends: {:static, :integer},
             revive_setting: {:ref, Torngen.Client.Schema.ReviveSetting},
             enemies: {:static, :integer},
             revivable: {:static, :boolean},
             karma: {:static, :integer},
             honor_id: {:ref, Torngen.Client.Schema.HonorId},
             gender: {:ref, Torngen.Client.Schema.UserGenderEnum},
             forum_posts: {:static, :integer},
             donator_status:
               {:one_of, [static: :null, ref: Torngen.Client.Schema.UserDonatorStatusEnum]},
             age: {:static, :integer}
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

  defp validate_key?(:profile, value) do
    Torngen.Client.Schema.validate?(
      value,
      {:object,
       %{
         id: {:ref, Torngen.Client.Schema.UserId},
         name: {:static, :string},
         status: {:ref, Torngen.Client.Schema.UserStatus},
         level: {:static, :integer},
         title: {:one_of, [static: :string, ref: Torngen.Client.Schema.UserTitleEnum]},
         property:
           {:object, %{id: {:ref, Torngen.Client.Schema.PropertyId}, name: {:static, :string}}},
         image: {:one_of, [static: :null, static: :string]},
         role: {:ref, Torngen.Client.Schema.UserRoleEnum},
         awards: {:static, :integer},
         last_action: {:ref, Torngen.Client.Schema.UserLastAction},
         life: {:object, %{maximum: {:static, :integer}, current: {:static, :integer}}},
         signed_up: {:static, :integer},
         rank: {:one_of, [static: :string, ref: Torngen.Client.Schema.UserRankEnum]},
         faction_id: {:one_of, [static: :null, ref: Torngen.Client.Schema.FactionId]},
         spouse: {:one_of, [static: :null, ref: Torngen.Client.Schema.ProfileSpouse]},
         friends: {:static, :integer},
         revive_setting: {:ref, Torngen.Client.Schema.ReviveSetting},
         enemies: {:static, :integer},
         revivable: {:static, :boolean},
         karma: {:static, :integer},
         honor_id: {:ref, Torngen.Client.Schema.HonorId},
         gender: {:ref, Torngen.Client.Schema.UserGenderEnum},
         forum_posts: {:static, :integer},
         donator_status:
           {:one_of, [static: :null, ref: Torngen.Client.Schema.UserDonatorStatusEnum]},
         age: {:static, :integer}
       }}
    )
  end

  @spec keys() :: list(atom())
  def keys(), do: @keys
end
