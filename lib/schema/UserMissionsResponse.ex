defmodule Torngen.Client.Schema.UserMissionsResponse do
  @moduledoc false

  use Torngen.Client.SchemaObjectAccess, deprecated: []

  @behaviour Torngen.Client.Schema

  @keys [:missions]

  defstruct [
    :missions
  ]

  @type t :: %__MODULE__{
          missions: %{
            :rewards => [
              %{
                :type => Torngen.Client.Schema.MissionRewardUpgrade.t(),
                :expires_at => integer(),
                :details =>
                  Torngen.Client.Schema.MissionRewardDetailsItem.t()
                  | Torngen.Client.Schema.MissionRewardDetailsUpgrade.t()
                  | Torngen.Client.Schema.MissionRewardDetailsAmmo.t(),
                :cost => integer(),
                :amount => integer()
              }
            ],
            :givers => [
              %{
                :name => String.t(),
                :id => Torngen.Client.Schema.UserId.t(),
                :contracts => [
                  %{
                    :title => String.t(),
                    :status => Torngen.Client.Schema.MissionStatusEnum.t(),
                    :started_at => nil | integer(),
                    :rewards => nil | %{:money => integer(), :credits => integer()},
                    :expires_at => nil | integer(),
                    :difficulty => Torngen.Client.Schema.MissionDifficultyEnum.t(),
                    :created_at => integer(),
                    :completed_at => nil | integer()
                  }
                ]
              }
            ],
            :credits => integer()
          }
        }

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      missions:
        data
        |> Map.get("missions")
        |> Torngen.Client.Schema.parse(
          {:object,
           %{
             credits: {:static, :integer},
             rewards:
               {:array,
                {:object,
                 %{
                   type: Torngen.Client.Schema.MissionRewardUpgrade,
                   details:
                     {:one_of,
                      [
                        Torngen.Client.Schema.MissionRewardDetailsItem,
                        Torngen.Client.Schema.MissionRewardDetailsUpgrade,
                        Torngen.Client.Schema.MissionRewardDetailsAmmo
                      ]},
                   cost: {:static, :integer},
                   amount: {:static, :integer},
                   expires_at: {:static, :integer}
                 }}},
             givers:
               {:array,
                {:object,
                 %{
                   id: Torngen.Client.Schema.UserId,
                   name: {:static, :string},
                   contracts:
                     {:array,
                      {:object,
                       %{
                         status: Torngen.Client.Schema.MissionStatusEnum,
                         title: {:static, :string},
                         started_at: {:one_of, [static: :null, static: :integer]},
                         rewards:
                           {:one_of,
                            [
                              static: :null,
                              object: %{credits: {:static, :integer}, money: {:static, :integer}}
                            ]},
                         expires_at: {:one_of, [static: :null, static: :integer]},
                         difficulty: Torngen.Client.Schema.MissionDifficultyEnum,
                         created_at: {:static, :integer},
                         completed_at: {:one_of, [static: :null, static: :integer]}
                       }}}
                 }}}
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

  defp validate_key?(:missions, value) do
    Torngen.Client.Schema.validate?(
      value,
      {:object,
       %{
         credits: {:static, :integer},
         rewards:
           {:array,
            {:object,
             %{
               type: Torngen.Client.Schema.MissionRewardUpgrade,
               details:
                 {:one_of,
                  [
                    Torngen.Client.Schema.MissionRewardDetailsItem,
                    Torngen.Client.Schema.MissionRewardDetailsUpgrade,
                    Torngen.Client.Schema.MissionRewardDetailsAmmo
                  ]},
               cost: {:static, :integer},
               amount: {:static, :integer},
               expires_at: {:static, :integer}
             }}},
         givers:
           {:array,
            {:object,
             %{
               id: Torngen.Client.Schema.UserId,
               name: {:static, :string},
               contracts:
                 {:array,
                  {:object,
                   %{
                     status: Torngen.Client.Schema.MissionStatusEnum,
                     title: {:static, :string},
                     started_at: {:one_of, [static: :null, static: :integer]},
                     rewards:
                       {:one_of,
                        [
                          static: :null,
                          object: %{credits: {:static, :integer}, money: {:static, :integer}}
                        ]},
                     expires_at: {:one_of, [static: :null, static: :integer]},
                     difficulty: Torngen.Client.Schema.MissionDifficultyEnum,
                     created_at: {:static, :integer},
                     completed_at: {:one_of, [static: :null, static: :integer]}
                   }}}
             }}}
       }}
    )
  end

  @spec keys() :: list(atom())
  def keys(), do: @keys
end
