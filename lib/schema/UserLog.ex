defmodule Torngen.Client.Schema.UserLog do
  @moduledoc false

  use Torngen.Client.SchemaObjectAccess, deprecated: []

  @behaviour Torngen.Client.Schema

  @keys [:timestamp, :params, :id, :details, :data]

  defstruct [
    :timestamp,
    :params,
    :id,
    :details,
    :data
  ]

  @type t :: %__MODULE__{
          timestamp: integer(),
          params: %{},
          id: Torngen.Client.Schema.UserLogId.t(),
          details: %{
            :title => String.t(),
            :id => Torngen.Client.Schema.LogId.t(),
            :category => String.t()
          },
          data: %{}
        }

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      timestamp: data |> Map.get("timestamp") |> Torngen.Client.Schema.parse({:static, :integer}),
      params: data |> Map.get("params") |> Torngen.Client.Schema.parse({:object, :any}),
      id: data |> Map.get("id") |> Torngen.Client.Schema.parse(Torngen.Client.Schema.UserLogId),
      details:
        data
        |> Map.get("details")
        |> Torngen.Client.Schema.parse(
          {:object,
           %{
             id: Torngen.Client.Schema.LogId,
             title: {:static, :string},
             category: {:static, :string}
           }}
        ),
      data: data |> Map.get("data") |> Torngen.Client.Schema.parse({:object, :any})
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

  defp validate_key?(:params, value) do
    Torngen.Client.Schema.validate?(value, {:object, :any})
  end

  defp validate_key?(:id, value) do
    Torngen.Client.Schema.validate?(value, Torngen.Client.Schema.UserLogId)
  end

  defp validate_key?(:details, value) do
    Torngen.Client.Schema.validate?(
      value,
      {:object,
       %{id: Torngen.Client.Schema.LogId, title: {:static, :string}, category: {:static, :string}}}
    )
  end

  defp validate_key?(:data, value) do
    Torngen.Client.Schema.validate?(value, {:object, :any})
  end

  @spec keys() :: list(atom())
  def keys(), do: @keys
end
