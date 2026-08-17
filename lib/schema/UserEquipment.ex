defmodule Torngen.Client.Schema.UserEquipment do
  @moduledoc false

  @behaviour Torngen.Client.Schema

  defstruct [:values]

  @type t :: %__MODULE__{
          values: [
            %{
              slot: integer(),
              mods: [Torngen.Client.Schema.UserEquipmentItemMod.t()],
              ammo: nil | Torngen.Client.Schema.UserEquipmentAmmo.t()
            }
            | Torngen.Client.Schema.TornItemDetails.t()
          ]
        }
  @types [
    {:object,
     %{
       slot: {:static, :integer},
       mods: {:array, {:ref, Torngen.Client.Schema.UserEquipmentItemMod}},
       ammo: {:one_of, [static: :null, ref: Torngen.Client.Schema.UserEquipmentAmmo]}
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
             ammo: {:one_of, [static: :null, ref: Torngen.Client.Schema.UserEquipmentAmmo]}
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
