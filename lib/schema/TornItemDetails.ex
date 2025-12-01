defmodule Torngen.Client.Schema.TornItemDetails do
  @moduledoc false

  @behaviour Torngen.Client.Schema

  defstruct [:values]

  @type t :: %__MODULE__{
          values: [
            %{
              :type => Torngen.Client.Schema.TornItemTypeEnum.t(),
              :sub_type => nil | Torngen.Client.Schema.TornItemWeaponTypeEnum.t(),
              :name => String.t(),
              :id => Torngen.Client.Schema.ItemId.t()
            }
            | Torngen.Client.Schema.ItemMarketListingItemDetails.t()
          ]
        }

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      values: [
        data
        |> Torngen.Client.Schema.parse(
          {:object,
           %{
             id: Torngen.Client.Schema.ItemId,
             name: {:static, :string},
             type: Torngen.Client.Schema.TornItemTypeEnum,
             sub_type: {:one_of, [{:static, :null}, Torngen.Client.Schema.TornItemWeaponTypeEnum]}
           }}
        ),
        data |> Torngen.Client.Schema.parse(Torngen.Client.Schema.ItemMarketListingItemDetails)
      ]
    }
  end

  @impl true
  def parse(_data), do: nil

  @impl true
  def validate?(%{} = _data), do: true

  @impl true
  def validate?(_data), do: false
end
