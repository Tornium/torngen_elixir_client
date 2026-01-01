defmodule Torngen.Client.Schema.UserRefillsResponse do
  @moduledoc false

  use Torngen.Client.SchemaObjectAccess, deprecated: []

  @behaviour Torngen.Client.Schema

  @keys [:refills]

  defstruct [
    :refills
  ]

  @type t :: %__MODULE__{
          refills: %{
            token: boolean(),
            special_count: integer(),
            nerve: boolean(),
            energy: boolean()
          }
        }

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      refills:
        data
        |> Map.get("refills")
        |> Torngen.Client.Schema.parse(
          {:object,
           %{
             token: {:static, :boolean},
             nerve: {:static, :boolean},
             energy: {:static, :boolean},
             special_count: {:static, :integer}
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

  defp validate_key?(:refills, value) do
    Torngen.Client.Schema.validate?(
      value,
      {:object,
       %{
         token: {:static, :boolean},
         nerve: {:static, :boolean},
         energy: {:static, :boolean},
         special_count: {:static, :integer}
       }}
    )
  end

  @spec keys() :: list(atom())
  def keys(), do: @keys
end
