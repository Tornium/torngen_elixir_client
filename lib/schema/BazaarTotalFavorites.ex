defmodule Torngen.Client.Schema.BazaarTotalFavorites do
  @moduledoc false

  @behaviour Torngen.Client.Schema

  defstruct [:values]

  @type t :: %__MODULE__{
          values: [%{:total_favorites => integer()} | Torngen.Client.Schema.Bazaar.t()]
        }

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      values: [
        data
        |> Torngen.Client.Schema.parse({:object, %{"total_favorites" => {:static, :integer}}}),
        data |> Torngen.Client.Schema.parse(Torngen.Client.Schema.Bazaar)
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
