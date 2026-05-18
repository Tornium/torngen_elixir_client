defmodule Torngen.Client.Schema.UserEquipment do
  @moduledoc false

  @behaviour Torngen.Client.Schema

  defstruct [:values]

  @type t :: %__MODULE__{
          values: [
            %{
              slot: integer(),
              mods: [Torngen.Client.Schema.UserEquipmentItemMod.t()],
              ammo: %{
                type: Torngen.Client.Schema.TornItemAmmoTypeEnum.t(),
                quantity: integer(),
                name: String.t(),
                id: Torngen.Client.Schema.AmmoId.t()
              }
            }
            | Torngen.Client.Schema.TornItemDetails.t()
          ]
        }
  @types [
    {:object,
     %{
       slot: {:static, :integer},
       mods: {:array, {:ref, Torngen.Client.Schema.UserEquipmentItemMod}},
       ammo:
         {:object,
          %{
            id: {:ref, Torngen.Client.Schema.AmmoId},
            name: {:static, :string},
            type: {:ref, Torngen.Client.Schema.TornItemAmmoTypeEnum},
            quantity: {:static, :integer}
          }}
     }},
    {:ref, Torngen.Client.Schema.TornItemDetails}
  ]

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      values: [
        data
        |> Torngen.Client.Schema.parse(
          {:object,
           %{
             slot: {:static, :integer},
             mods: {:array, {:ref, Torngen.Client.Schema.UserEquipmentItemMod}},
             ammo:
               {:object,
                %{
                  id: {:ref, Torngen.Client.Schema.AmmoId},
                  name: {:static, :string},
                  type: {:ref, Torngen.Client.Schema.TornItemAmmoTypeEnum},
                  quantity: {:static, :integer}
                }}
           }}
        ),
        data |> Torngen.Client.Schema.parse({:ref, Torngen.Client.Schema.TornItemDetails})
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
