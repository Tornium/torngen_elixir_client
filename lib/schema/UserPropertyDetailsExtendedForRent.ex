defmodule Torngen.Client.Schema.UserPropertyDetailsExtendedForRent do
  @moduledoc false

  @behaviour Torngen.Client.Schema

  defstruct [:values]

  @type t :: %__MODULE__{
          values: [
            %{
              used_by: [Torngen.Client.Schema.BasicUser.t()],
              status: String.t(),
              renter_asked: nil | Torngen.Client.Schema.BasicUser.t(),
              rental_period: integer(),
              cost_per_day: integer(),
              cost: integer()
            }
            | Torngen.Client.Schema.UserPropertyBasicDetails.t()
          ]
        }
  @types [
    {:object,
     %{
       status: {:enum, :string, ["for_rent"]},
       rental_period: {:static, :integer},
       cost_per_day: {:static, :integer},
       cost: {:static, :integer},
       used_by: {:array, {:ref, Torngen.Client.Schema.BasicUser}},
       renter_asked: {:one_of, [static: :null, ref: Torngen.Client.Schema.BasicUser]}
     }},
    {:ref, Torngen.Client.Schema.UserPropertyBasicDetails}
  ]

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      values: [
        data
        |> Torngen.Client.Schema.parse(
          {:object,
           %{
             status: {:enum, :string, ["for_rent"]},
             rental_period: {:static, :integer},
             cost_per_day: {:static, :integer},
             cost: {:static, :integer},
             used_by: {:array, {:ref, Torngen.Client.Schema.BasicUser}},
             renter_asked: {:one_of, [static: :null, ref: Torngen.Client.Schema.BasicUser]}
           }}
        ),
        data
        |> Torngen.Client.Schema.parse({:ref, Torngen.Client.Schema.UserPropertyBasicDetails})
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
