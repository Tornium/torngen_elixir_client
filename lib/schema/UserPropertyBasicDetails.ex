defmodule Torngen.Client.Schema.UserPropertyBasicDetails do
  @moduledoc false

  use Torngen.Client.SchemaObjectAccess, deprecated: []

  @behaviour Torngen.Client.Schema

  @keys [:upkeep, :staff, :property, :owner, :modifications, :market_price, :id, :happy]

  defstruct [
    :upkeep,
    :staff,
    :property,
    :owner,
    :modifications,
    :market_price,
    :id,
    :happy
  ]

  @type t :: %__MODULE__{
          upkeep: %{:staff => integer(), :property => integer()},
          staff: [%{:type => Torngen.Client.Schema.PropertyStaffEnum.t(), :amount => integer()}],
          property: Torngen.Client.Schema.BasicProperty.t(),
          owner: Torngen.Client.Schema.BasicUser.t(),
          modifications: [Torngen.Client.Schema.PropertyModificationEnum.t()],
          market_price: integer(),
          id: Torngen.Client.Schema.PropertyId.t(),
          happy: integer()
        }

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      upkeep:
        data
        |> Map.get("upkeep")
        |> Torngen.Client.Schema.parse(
          {:object, %{"property" => {:static, :integer}, "staff" => {:static, :integer}}}
        ),
      staff:
        data
        |> Map.get("staff")
        |> Torngen.Client.Schema.parse(
          {:array,
           {:object,
            %{"amount" => {:static, :integer}, "type" => Torngen.Client.Schema.PropertyStaffEnum}}}
        ),
      property:
        data
        |> Map.get("property")
        |> Torngen.Client.Schema.parse(Torngen.Client.Schema.BasicProperty),
      owner:
        data |> Map.get("owner") |> Torngen.Client.Schema.parse(Torngen.Client.Schema.BasicUser),
      modifications:
        data
        |> Map.get("modifications")
        |> Torngen.Client.Schema.parse({:array, Torngen.Client.Schema.PropertyModificationEnum}),
      market_price:
        data |> Map.get("market_price") |> Torngen.Client.Schema.parse({:static, :integer}),
      id: data |> Map.get("id") |> Torngen.Client.Schema.parse(Torngen.Client.Schema.PropertyId),
      happy: data |> Map.get("happy") |> Torngen.Client.Schema.parse({:static, :integer})
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

  defp validate_key?(:upkeep, value) do
    Torngen.Client.Schema.validate?(
      value,
      {:object, %{"property" => {:static, :integer}, "staff" => {:static, :integer}}}
    )
  end

  defp validate_key?(:staff, value) do
    Torngen.Client.Schema.validate?(
      value,
      {:array,
       {:object,
        %{"amount" => {:static, :integer}, "type" => Torngen.Client.Schema.PropertyStaffEnum}}}
    )
  end

  defp validate_key?(:property, value) do
    Torngen.Client.Schema.validate?(value, Torngen.Client.Schema.BasicProperty)
  end

  defp validate_key?(:owner, value) do
    Torngen.Client.Schema.validate?(value, Torngen.Client.Schema.BasicUser)
  end

  defp validate_key?(:modifications, value) do
    Torngen.Client.Schema.validate?(
      value,
      {:array, Torngen.Client.Schema.PropertyModificationEnum}
    )
  end

  defp validate_key?(:market_price, value) do
    Torngen.Client.Schema.validate?(value, {:static, :integer})
  end

  defp validate_key?(:id, value) do
    Torngen.Client.Schema.validate?(value, Torngen.Client.Schema.PropertyId)
  end

  defp validate_key?(:happy, value) do
    Torngen.Client.Schema.validate?(value, {:static, :integer})
  end

  @spec keys() :: list(atom())
  def keys(), do: @keys
end
