defmodule Torngen.Client.Schema.UserPropertyDetailsExtendedRented do
  @moduledoc false

  @behaviour Torngen.Client.Schema

  defstruct [:values]

  @type t :: %__MODULE__{
          values: [
            %{
              used_by: [Torngen.Client.Schema.BasicUser.t()],
              status: String.t(),
              rented_by: Torngen.Client.Schema.BasicUser.t(),
              rental_period_remaining: integer(),
              rental_period: integer(),
              lease_extension: nil | %{period: integer(), created_at: integer(), cost: integer()},
              cost_per_day: integer(),
              cost: integer()
            }
            | Torngen.Client.Schema.UserPropertyBasicDetails.t()
          ]
        }
  @types [
    {:object,
     %{
       status: {:enum, :string, ["rented"]},
       rental_period: {:static, :integer},
       cost_per_day: {:static, :integer},
       cost: {:static, :integer},
       used_by: {:array, {:ref, Torngen.Client.Schema.BasicUser}},
       rented_by: {:ref, Torngen.Client.Schema.BasicUser},
       rental_period_remaining: {:static, :integer},
       lease_extension:
         {:one_of,
          [
            static: :null,
            object: %{
              period: {:static, :integer},
              cost: {:static, :integer},
              created_at: {:static, :integer}
            }
          ]}
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
             status: {:enum, :string, ["rented"]},
             rental_period: {:static, :integer},
             cost_per_day: {:static, :integer},
             cost: {:static, :integer},
             used_by: {:array, {:ref, Torngen.Client.Schema.BasicUser}},
             rented_by: {:ref, Torngen.Client.Schema.BasicUser},
             rental_period_remaining: {:static, :integer},
             lease_extension:
               {:one_of,
                [
                  static: :null,
                  object: %{
                    period: {:static, :integer},
                    cost: {:static, :integer},
                    created_at: {:static, :integer}
                  }
                ]}
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
