defmodule Torngen.Client.Schema.UserCriminalRecordResponse do
  @moduledoc false

  use Torngen.Client.SchemaObjectAccess, deprecated: []

  @behaviour Torngen.Client.Schema

  @keys [:criminalrecord]

  defstruct [
    :criminalrecord
  ]

  @type t :: %__MODULE__{
          criminalrecord:
            Torngen.Client.Schema.UserCriminalRecordV1.t()
            | Torngen.Client.Schema.UserCriminalRecordV2.t()
        }

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      criminalrecord:
        data
        |> Map.get("criminalrecord")
        |> Torngen.Client.Schema.parse(
          {:one_of,
           [
             ref: Torngen.Client.Schema.UserCriminalRecordV1,
             ref: Torngen.Client.Schema.UserCriminalRecordV2
           ]}
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

  defp validate_key?(:criminalrecord, value) do
    Torngen.Client.Schema.validate?(
      value,
      {:one_of,
       [
         ref: Torngen.Client.Schema.UserCriminalRecordV1,
         ref: Torngen.Client.Schema.UserCriminalRecordV2
       ]}
    )
  end

  @spec keys() :: list(atom())
  def keys(), do: @keys
end
