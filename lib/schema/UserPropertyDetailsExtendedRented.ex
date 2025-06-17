defmodule Torngen.Client.Schema.UserPropertyDetailsExtendedRented do
  @moduledoc false

  @behaviour Torngen.Client.Schema

  defstruct [:values]

  @type t :: %__MODULE__{
          values: [
            %{
              :used_by => [Torngen.Client.Schema.BasicUser.t()],
              :status => String.t(),
              :rental_period_remaining => integer(),
              :rental_period => integer(),
              :cost_per_day => integer(),
              :cost => integer()
            }
            | Torngen.Client.Schema.UserPropertyBasicDetails.t()
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
             "cost" => {:static, :integer},
             "cost_per_day" => {:static, :integer},
             "rental_period" => {:static, :integer},
             "rental_period_remaining" => {:static, :integer},
             "status" => {:enum, :string, ["rented"]},
             "used_by" => {:array, Torngen.Client.Schema.BasicUser}
           }}
        ),
        data |> Torngen.Client.Schema.parse(Torngen.Client.Schema.UserPropertyBasicDetails)
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
