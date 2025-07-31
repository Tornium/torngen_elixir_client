defmodule Torngen.Client.Schema.PersonalStatsBounties do
  @moduledoc false

  use Torngen.Client.SchemaObjectAccess, deprecated: []

  @behaviour Torngen.Client.Schema

  @keys [:bounties]

  defstruct [
    :bounties
  ]

  @type t :: %__MODULE__{
          bounties: %{
            :received => %{:value => integer(), :amount => integer()},
            :placed => %{:value => integer(), :amount => integer()},
            :collected => %{:value => integer(), :amount => integer()}
          }
        }

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      bounties:
        data
        |> Map.get("bounties")
        |> Torngen.Client.Schema.parse(
          {:object,
           %{
             received: {:object, %{value: {:static, :integer}, amount: {:static, :integer}}},
             placed: {:object, %{value: {:static, :integer}, amount: {:static, :integer}}},
             collected: {:object, %{value: {:static, :integer}, amount: {:static, :integer}}}
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

  defp validate_key?(:bounties, value) do
    Torngen.Client.Schema.validate?(
      value,
      {:object,
       %{
         received: {:object, %{value: {:static, :integer}, amount: {:static, :integer}}},
         placed: {:object, %{value: {:static, :integer}, amount: {:static, :integer}}},
         collected: {:object, %{value: {:static, :integer}, amount: {:static, :integer}}}
       }}
    )
  end

  @spec keys() :: list(atom())
  def keys(), do: @keys
end
