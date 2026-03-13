defmodule Torngen.Client.Schema.TradeItemItem do
  @moduledoc false

  use Torngen.Client.SchemaObjectAccess, deprecated: []

  @behaviour Torngen.Client.Schema

  @keys [:user_id, :type, :details]

  defstruct [
    :user_id,
    :type,
    :details
  ]

  @type t :: %__MODULE__{
          user_id: Torngen.Client.Schema.UserId.t(),
          type: String.t(),
          details: %{
            uid: nil | Torngen.Client.Schema.ItemUid.t(),
            id: Torngen.Client.Schema.ItemId.t(),
            amount: integer()
          }
        }

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      user_id:
        data
        |> Map.get("user_id")
        |> Torngen.Client.Schema.parse({:ref, Torngen.Client.Schema.UserId}),
      type: data |> Map.get("type") |> Torngen.Client.Schema.parse({:enum, :string, ["Item"]}),
      details:
        data
        |> Map.get("details")
        |> Torngen.Client.Schema.parse(
          {:object,
           %{
             id: {:ref, Torngen.Client.Schema.ItemId},
             uid: {:one_of, [static: :null, ref: Torngen.Client.Schema.ItemUid]},
             amount: {:static, :integer}
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

  defp validate_key?(:user_id, value) do
    Torngen.Client.Schema.validate?(value, {:ref, Torngen.Client.Schema.UserId})
  end

  defp validate_key?(:type, value) do
    Torngen.Client.Schema.validate?(value, {:enum, :string, ["Item"]})
  end

  defp validate_key?(:details, value) do
    Torngen.Client.Schema.validate?(
      value,
      {:object,
       %{
         id: {:ref, Torngen.Client.Schema.ItemId},
         uid: {:one_of, [static: :null, ref: Torngen.Client.Schema.ItemUid]},
         amount: {:static, :integer}
       }}
    )
  end

  @spec keys() :: list(atom())
  def keys(), do: @keys
end
