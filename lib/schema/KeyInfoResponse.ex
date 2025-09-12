defmodule Torngen.Client.Schema.KeyInfoResponse do
  @moduledoc false

  use Torngen.Client.SchemaObjectAccess, deprecated: []

  @behaviour Torngen.Client.Schema

  @keys [:info]

  defstruct [
    :info
  ]

  @type t :: %__MODULE__{
          info: %{
            :user => %{
              :id => Torngen.Client.Schema.UserId.t(),
              :faction_id => nil | Torngen.Client.Schema.FactionId.t(),
              :company_id => nil | Torngen.Client.Schema.CompanyId.t()
            },
            :selections => %{
              :user => [Torngen.Client.Schema.UserSelectionName.t()],
              :torn => [Torngen.Client.Schema.TornSelectionName.t()],
              :racing => [Torngen.Client.Schema.RacingSelectionName.t()],
              :property => [String.t()],
              :market => [Torngen.Client.Schema.MarketSelectionName.t()],
              :key => [Torngen.Client.Schema.KeySelectionName.t()],
              :forum => [Torngen.Client.Schema.ForumSelectionName.t()],
              :faction => [Torngen.Client.Schema.FactionSelectionName.t()],
              :company => [String.t()]
            },
            :access => %{
              :type => Torngen.Client.Schema.ApiKeyAccessTypeEnum.t(),
              :log => %{
                :custom_permissions => boolean(),
                :available => [Torngen.Client.Schema.KeyInfoAvailableLog.t()]
              },
              :level => integer(),
              :faction => boolean(),
              :company => boolean()
            }
          }
        }

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      info:
        data
        |> Map.get("info")
        |> Torngen.Client.Schema.parse(
          {:object,
           %{
             access:
               {:object,
                %{
                  type: Torngen.Client.Schema.ApiKeyAccessTypeEnum,
                  log:
                    {:object,
                     %{
                       available: {:array, Torngen.Client.Schema.KeyInfoAvailableLog},
                       custom_permissions: {:static, :boolean}
                     }},
                  level: {:static, :integer},
                  faction: {:static, :boolean},
                  company: {:static, :boolean}
                }},
             user:
               {:object,
                %{
                  id: Torngen.Client.Schema.UserId,
                  faction_id: {:one_of, [{:static, :null}, Torngen.Client.Schema.FactionId]},
                  company_id: {:one_of, [{:static, :null}, Torngen.Client.Schema.CompanyId]}
                }},
             selections:
               {:object,
                %{
                  user: {:array, Torngen.Client.Schema.UserSelectionName},
                  property: {:array, {:static, :string}},
                  key: {:array, Torngen.Client.Schema.KeySelectionName},
                  faction: {:array, Torngen.Client.Schema.FactionSelectionName},
                  company: {:array, {:static, :string}},
                  market: {:array, Torngen.Client.Schema.MarketSelectionName},
                  torn: {:array, Torngen.Client.Schema.TornSelectionName},
                  racing: {:array, Torngen.Client.Schema.RacingSelectionName},
                  forum: {:array, Torngen.Client.Schema.ForumSelectionName}
                }}
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

  defp validate_key?(:info, value) do
    Torngen.Client.Schema.validate?(
      value,
      {:object,
       %{
         access:
           {:object,
            %{
              type: Torngen.Client.Schema.ApiKeyAccessTypeEnum,
              log:
                {:object,
                 %{
                   available: {:array, Torngen.Client.Schema.KeyInfoAvailableLog},
                   custom_permissions: {:static, :boolean}
                 }},
              level: {:static, :integer},
              faction: {:static, :boolean},
              company: {:static, :boolean}
            }},
         user:
           {:object,
            %{
              id: Torngen.Client.Schema.UserId,
              faction_id: {:one_of, [{:static, :null}, Torngen.Client.Schema.FactionId]},
              company_id: {:one_of, [{:static, :null}, Torngen.Client.Schema.CompanyId]}
            }},
         selections:
           {:object,
            %{
              user: {:array, Torngen.Client.Schema.UserSelectionName},
              property: {:array, {:static, :string}},
              key: {:array, Torngen.Client.Schema.KeySelectionName},
              faction: {:array, Torngen.Client.Schema.FactionSelectionName},
              company: {:array, {:static, :string}},
              market: {:array, Torngen.Client.Schema.MarketSelectionName},
              torn: {:array, Torngen.Client.Schema.TornSelectionName},
              racing: {:array, Torngen.Client.Schema.RacingSelectionName},
              forum: {:array, Torngen.Client.Schema.ForumSelectionName}
            }}
       }}
    )
  end

  @spec keys() :: list(atom())
  def keys(), do: @keys
end
