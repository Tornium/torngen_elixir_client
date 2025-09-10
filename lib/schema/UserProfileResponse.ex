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
            :title => Torngen.Client.Schema.UserTitleEnum.t(),
            :status => Torngen.Client.Schema.UserStatus.t(),
            :spouse => nil | Torngen.Client.Schema.ProfileSpouse.t(),
            :signed_up => integer(),
            :role => Torngen.Client.Schema.UserRoleEnum.t(),
            :revivable => boolean(),
            :rank => Torngen.Client.Schema.UserRankEnum.t(),
            :property => %{:name => String.t(), :id => Torngen.Client.Schema.PropertyId.t()},
            :name => String.t(),
            :life => %{:maximum => integer(), :current => integer()},
            :level => integer(),
            :last_action => Torngen.Client.Schema.UserLastAction.t(),
            :karma => integer(),
            :image => nil | String.t(),
            :id => Torngen.Client.Schema.UserId.t(),
            :honor_id => Torngen.Client.Schema.HonorId.t(),
            :gender => Torngen.Client.Schema.UserGenderEnum.t(),
            :friends => integer(),
            :forum_posts => integer(),
            :faction_id => nil | Torngen.Client.Schema.FactionId.t(),
            :enemies => integer(),
            :donator_status => nil | Torngen.Client.Schema.UserDonatorStatusEnum.t(),
            :awards => integer(),
            :age => integer()
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
             id: Torngen.Client.Schema.UserId,
             name: {:static, :string},
             status: Torngen.Client.Schema.UserStatus,
             level: {:static, :integer},
             title: Torngen.Client.Schema.UserTitleEnum,
             property:
               {:object, %{id: Torngen.Client.Schema.PropertyId, name: {:static, :string}}},
             image: {:one_of, [static: :null, static: :string]},
             role: Torngen.Client.Schema.UserRoleEnum,
             awards: {:static, :integer},
             last_action: Torngen.Client.Schema.UserLastAction,
             rank: Torngen.Client.Schema.UserRankEnum,
             spouse: {:one_of, [{:static, :null}, Torngen.Client.Schema.ProfileSpouse]},
             friends: {:static, :integer},
             faction_id: {:one_of, [{:static, :null}, Torngen.Client.Schema.FactionId]},
             signed_up: {:static, :integer},
             revivable: {:static, :boolean},
             life: {:object, %{maximum: {:static, :integer}, current: {:static, :integer}}},
             karma: {:static, :integer},
             honor_id: Torngen.Client.Schema.HonorId,
             gender: Torngen.Client.Schema.UserGenderEnum,
             forum_posts: {:static, :integer},
             enemies: {:static, :integer},
             donator_status:
               {:one_of, [{:static, :null}, Torngen.Client.Schema.UserDonatorStatusEnum]},
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
         id: Torngen.Client.Schema.UserId,
         name: {:static, :string},
         status: Torngen.Client.Schema.UserStatus,
         level: {:static, :integer},
         title: Torngen.Client.Schema.UserTitleEnum,
         property: {:object, %{id: Torngen.Client.Schema.PropertyId, name: {:static, :string}}},
         image: {:one_of, [static: :null, static: :string]},
         role: Torngen.Client.Schema.UserRoleEnum,
         awards: {:static, :integer},
         last_action: Torngen.Client.Schema.UserLastAction,
         rank: Torngen.Client.Schema.UserRankEnum,
         spouse: {:one_of, [{:static, :null}, Torngen.Client.Schema.ProfileSpouse]},
         friends: {:static, :integer},
         faction_id: {:one_of, [{:static, :null}, Torngen.Client.Schema.FactionId]},
         signed_up: {:static, :integer},
         revivable: {:static, :boolean},
         life: {:object, %{maximum: {:static, :integer}, current: {:static, :integer}}},
         karma: {:static, :integer},
         honor_id: Torngen.Client.Schema.HonorId,
         gender: Torngen.Client.Schema.UserGenderEnum,
         forum_posts: {:static, :integer},
         enemies: {:static, :integer},
         donator_status:
           {:one_of, [{:static, :null}, Torngen.Client.Schema.UserDonatorStatusEnum]},
         age: {:static, :integer}
       }}
    )
  end

  @spec keys() :: list(atom())
  def keys(), do: @keys
end
