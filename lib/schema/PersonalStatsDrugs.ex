defmodule Torngen.Client.Schema.PersonalStatsDrugs do
  @moduledoc false

  use Torngen.Client.SchemaObjectAccess, deprecated: []

  @behaviour Torngen.Client.Schema

  @keys [:drugs]

  defstruct [
    :drugs
  ]

  @type t :: %__MODULE__{
          drugs: %{
            xanax: integer(),
            vicodin: integer(),
            total: integer(),
            speed: integer(),
            shrooms: integer(),
            rehabilitations: %{fees: integer(), amount: integer()},
            pcp: integer(),
            overdoses: integer(),
            opium: integer(),
            lsd: integer(),
            ketamine: integer(),
            ecstasy: integer(),
            cannabis: integer()
          }
        }

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      drugs:
        data
        |> Map.get("drugs")
        |> Torngen.Client.Schema.parse(
          {:object,
           %{
             total: {:static, :integer},
             speed: {:static, :integer},
             xanax: {:static, :integer},
             vicodin: {:static, :integer},
             shrooms: {:static, :integer},
             pcp: {:static, :integer},
             overdoses: {:static, :integer},
             opium: {:static, :integer},
             lsd: {:static, :integer},
             ketamine: {:static, :integer},
             ecstasy: {:static, :integer},
             cannabis: {:static, :integer},
             rehabilitations: {:object, %{amount: {:static, :integer}, fees: {:static, :integer}}}
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

  defp validate_key?(:drugs, value) do
    Torngen.Client.Schema.validate?(
      value,
      {:object,
       %{
         total: {:static, :integer},
         speed: {:static, :integer},
         xanax: {:static, :integer},
         vicodin: {:static, :integer},
         shrooms: {:static, :integer},
         pcp: {:static, :integer},
         overdoses: {:static, :integer},
         opium: {:static, :integer},
         lsd: {:static, :integer},
         ketamine: {:static, :integer},
         ecstasy: {:static, :integer},
         cannabis: {:static, :integer},
         rehabilitations: {:object, %{amount: {:static, :integer}, fees: {:static, :integer}}}
       }}
    )
  end

  @spec keys() :: list(atom())
  def keys(), do: @keys
end
