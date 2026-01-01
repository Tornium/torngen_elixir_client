defmodule Torngen.Client.Schema.UserPropertyDetailsExtendedWithRent do
  @moduledoc false

  @behaviour Torngen.Client.Schema

  defstruct [:values]

  @type t :: %__MODULE__{
          values: [
            %{
              used_by: [Torngen.Client.Schema.BasicUser.t()],
              status: String.t(),
              rented_by: nil | Torngen.Client.Schema.BasicUser.t()
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
             status: {:enum, :string, ["none", "in_use"]},
             used_by: {:array, {:ref, Torngen.Client.Schema.BasicUser}},
             rented_by: {:one_of, [static: :null, ref: Torngen.Client.Schema.BasicUser]}
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
  def validate?(%{} = _data), do: true

  @impl true
  def validate?(_data), do: false
end
