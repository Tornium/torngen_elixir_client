defmodule Torngen.Client.Schema.UserPerksResponse do
  @moduledoc false

  use Torngen.Client.SchemaObjectAccess, deprecated: []

  @behaviour Torngen.Client.Schema

  @keys [:perks]

  defstruct [
    :perks
  ]

  @type t :: %__MODULE__{
          perks: %{
            stock: [String.t()],
            property: [String.t()],
            merit: [String.t()],
            job: [String.t()],
            faction: [String.t()],
            enhancer: [String.t()],
            education: [String.t()],
            book: [String.t()]
          }
        }

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      perks:
        data
        |> Map.get("perks")
        |> Torngen.Client.Schema.parse(
          {:object,
           %{
             property: {:array, {:static, :string}},
             education: {:array, {:static, :string}},
             faction: {:array, {:static, :string}},
             job: {:array, {:static, :string}},
             stock: {:array, {:static, :string}},
             merit: {:array, {:static, :string}},
             enhancer: {:array, {:static, :string}},
             book: {:array, {:static, :string}}
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

  defp validate_key?(:perks, value) do
    Torngen.Client.Schema.validate?(
      value,
      {:object,
       %{
         property: {:array, {:static, :string}},
         education: {:array, {:static, :string}},
         faction: {:array, {:static, :string}},
         job: {:array, {:static, :string}},
         stock: {:array, {:static, :string}},
         merit: {:array, {:static, :string}},
         enhancer: {:array, {:static, :string}},
         book: {:array, {:static, :string}}
       }}
    )
  end

  @spec keys() :: list(atom())
  def keys(), do: @keys
end
