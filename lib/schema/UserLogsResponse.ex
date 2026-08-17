defmodule Torngen.Client.Schema.UserLogsResponse do
  @moduledoc false

  use Torngen.Client.SchemaObjectAccess, deprecated: []

  @behaviour Torngen.Client.Schema

  @keys [:log, :_metadata]

  defstruct [
    :log,
    :_metadata
  ]

  @type t :: %__MODULE__{
          log: [Torngen.Client.Schema.UserLog.t()],
          _metadata: Torngen.Client.Schema.RequestMetadataWithLinksAndNanostamp.t()
        }

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      log:
        data
        |> Map.get("log")
        |> Torngen.Client.Schema.parse({:array, {:ref, Torngen.Client.Schema.UserLog}}),
      _metadata:
        data
        |> Map.get("_metadata")
        |> Torngen.Client.Schema.parse(
          {:ref, Torngen.Client.Schema.RequestMetadataWithLinksAndNanostamp}
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

  defp validate_key?(:log, value) do
    Torngen.Client.Schema.validate?(value, {:array, {:ref, Torngen.Client.Schema.UserLog}})
  end

  defp validate_key?(:_metadata, value) do
    Torngen.Client.Schema.validate?(
      value,
      {:ref, Torngen.Client.Schema.RequestMetadataWithLinksAndNanostamp}
    )
  end

  @spec keys() :: list(atom())
  def keys(), do: @keys
end
