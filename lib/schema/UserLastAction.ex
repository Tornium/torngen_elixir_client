defmodule Torngen.Client.Schema.UserLastAction do
  @moduledoc false

  use Torngen.Client.SchemaObjectAccess, deprecated: []

  @behaviour Torngen.Client.Schema

  @keys [:timestamp, :status, :relative]

  defstruct [
    :timestamp,
    :status,
    :relative
  ]

  @type t :: %__MODULE__{
          timestamp: integer(),
          status: Torngen.Client.Schema.UserLastActionStatusEnum.t(),
          relative: String.t()
        }

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      timestamp: data |> Map.get("timestamp") |> Torngen.Client.Schema.parse({:static, :integer}),
      status:
        data
        |> Map.get("status")
        |> Torngen.Client.Schema.parse(Torngen.Client.Schema.UserLastActionStatusEnum),
      relative: data |> Map.get("relative") |> Torngen.Client.Schema.parse({:static, :string})
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

  defp validate_key?(:timestamp, value) do
    Torngen.Client.Schema.validate?(value, {:static, :integer})
  end

  defp validate_key?(:status, value) do
    Torngen.Client.Schema.validate?(value, Torngen.Client.Schema.UserLastActionStatusEnum)
  end

  defp validate_key?(:relative, value) do
    Torngen.Client.Schema.validate?(value, {:static, :string})
  end

  @spec keys() :: list(atom())
  def keys(), do: @keys
end
