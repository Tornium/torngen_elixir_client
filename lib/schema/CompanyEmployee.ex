defmodule Torngen.Client.Schema.CompanyEmployee do
  @moduledoc false

  use Torngen.Client.SchemaObjectAccess, deprecated: []

  @behaviour Torngen.Client.Schema

  @keys [:status, :position, :name, :last_action, :id, :days_in_company]

  defstruct [
    :status,
    :position,
    :name,
    :last_action,
    :id,
    :days_in_company
  ]

  @type t :: %__MODULE__{
          status: Torngen.Client.Schema.UserStatus.t(),
          position: Torngen.Client.Schema.CompanyEmployeePosition.t(),
          name: String.t(),
          last_action: Torngen.Client.Schema.UserLastAction.t(),
          id: Torngen.Client.Schema.UserId.t(),
          days_in_company: integer()
        }

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      status:
        data
        |> Map.get("status")
        |> Torngen.Client.Schema.parse({:ref, Torngen.Client.Schema.UserStatus}),
      position:
        data
        |> Map.get("position")
        |> Torngen.Client.Schema.parse({:ref, Torngen.Client.Schema.CompanyEmployeePosition}),
      name: data |> Map.get("name") |> Torngen.Client.Schema.parse({:static, :string}),
      last_action:
        data
        |> Map.get("last_action")
        |> Torngen.Client.Schema.parse({:ref, Torngen.Client.Schema.UserLastAction}),
      id:
        data |> Map.get("id") |> Torngen.Client.Schema.parse({:ref, Torngen.Client.Schema.UserId}),
      days_in_company:
        data |> Map.get("days_in_company") |> Torngen.Client.Schema.parse({:static, :integer})
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

  defp validate_key?(:status, value) do
    Torngen.Client.Schema.validate?(value, {:ref, Torngen.Client.Schema.UserStatus})
  end

  defp validate_key?(:position, value) do
    Torngen.Client.Schema.validate?(value, {:ref, Torngen.Client.Schema.CompanyEmployeePosition})
  end

  defp validate_key?(:name, value) do
    Torngen.Client.Schema.validate?(value, {:static, :string})
  end

  defp validate_key?(:last_action, value) do
    Torngen.Client.Schema.validate?(value, {:ref, Torngen.Client.Schema.UserLastAction})
  end

  defp validate_key?(:id, value) do
    Torngen.Client.Schema.validate?(value, {:ref, Torngen.Client.Schema.UserId})
  end

  defp validate_key?(:days_in_company, value) do
    Torngen.Client.Schema.validate?(value, {:static, :integer})
  end

  @spec keys() :: list(atom())
  def keys(), do: @keys
end
