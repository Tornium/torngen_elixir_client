defmodule Torngen.Client.Schema.TornShopliftingSecurityStatus do
  @moduledoc false

  use Torngen.Client.SchemaObjectAccess, deprecated: []

  @behaviour Torngen.Client.Schema

  @keys [:title, :disabled]

  defstruct [
    :title,
    :disabled
  ]

  @type t :: %__MODULE__{
          title: Torngen.Client.Schema.TornShopliftingStatusTitleEnum.t(),
          disabled: boolean()
        }

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      title:
        data
        |> Map.get("title")
        |> Torngen.Client.Schema.parse(
          {:ref, Torngen.Client.Schema.TornShopliftingStatusTitleEnum}
        ),
      disabled: data |> Map.get("disabled") |> Torngen.Client.Schema.parse({:static, :boolean})
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

  defp validate_key?(:title, value) do
    Torngen.Client.Schema.validate?(
      value,
      {:ref, Torngen.Client.Schema.TornShopliftingStatusTitleEnum}
    )
  end

  defp validate_key?(:disabled, value) do
    Torngen.Client.Schema.validate?(value, {:static, :boolean})
  end

  @spec keys() :: list(atom())
  def keys(), do: @keys
end
