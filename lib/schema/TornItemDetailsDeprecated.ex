defmodule Torngen.Client.Schema.TornItemDetailsDeprecated do
  @moduledoc false

  @behaviour Torngen.Client.Schema

  defstruct [:values]

  @type t :: %__MODULE__{
          values: [
            %{
              type: Torngen.Client.Schema.TornItemTypeEnum.t(),
              sub_type: nil | Torngen.Client.Schema.TornItemWeaponTypeEnum.t(),
              name: String.t(),
              id: Torngen.Client.Schema.ItemId.t()
            }
            | Torngen.Client.Schema.ItemMarketListingItemDetails.t()
          ]
        }
  @types [
    {:object,
     %{
       id: {:ref, Torngen.Client.Schema.ItemId},
       name: {:static, :string},
       type: {:ref, Torngen.Client.Schema.TornItemTypeEnum},
       sub_type: {:one_of, [static: :null, ref: Torngen.Client.Schema.TornItemWeaponTypeEnum]}
     }},
    {:ref, Torngen.Client.Schema.ItemMarketListingItemDetails}
  ]

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      values: [
        data
        |> Torngen.Client.Schema.parse(
          {:object,
           %{
             id: {:ref, Torngen.Client.Schema.ItemId},
             name: {:static, :string},
             type: {:ref, Torngen.Client.Schema.TornItemTypeEnum},
             sub_type:
               {:one_of, [static: :null, ref: Torngen.Client.Schema.TornItemWeaponTypeEnum]}
           }}
        ),
        data
        |> Torngen.Client.Schema.parse({:ref, Torngen.Client.Schema.ItemMarketListingItemDetails})
      ]
    }
  end

  @impl true
  def parse(_data), do: nil

  @impl true
  def validate?(data) do
    Enum.all?(@types, fn type -> Torngen.Client.Schema.validate?(data, type) end)
  end
end
