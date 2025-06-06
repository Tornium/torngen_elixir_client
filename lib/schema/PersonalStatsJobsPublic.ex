defmodule Torngen.Client.Schema.PersonalStatsJobsPublic do
  @moduledoc false

  use Torngen.Client.SchemaObjectAccess, deprecated: []

  @behaviour Torngen.Client.Schema

  @keys [:jobs]

  defstruct [
    :jobs
  ]

  @type t :: %__MODULE__{
          jobs: %{:trains_received => integer(), :job_points_used => integer()}
        }

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      jobs:
        data
        |> Map.get("jobs")
        |> Torngen.Client.Schema.parse(
          {:object,
           %{"job_points_used" => {:static, :integer}, "trains_received" => {:static, :integer}}}
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

  defp validate_key?(:jobs, value) do
    Torngen.Client.Schema.validate?(
      value,
      {:object,
       %{"job_points_used" => {:static, :integer}, "trains_received" => {:static, :integer}}}
    )
  end

  @spec keys() :: list(atom())
  def keys(), do: @keys
end
