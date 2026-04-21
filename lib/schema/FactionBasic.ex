defmodule Torngen.Client.Schema.FactionBasic do
  @moduledoc false

  use Torngen.Client.SchemaObjectAccess, deprecated: []

  @behaviour Torngen.Client.Schema

  @keys [
    :tag_image,
    :tag,
    :respect,
    :rank,
    :note,
    :name,
    :members,
    :leader_id,
    :is_enlisted,
    :id,
    :days_old,
    :co_leader_id,
    :capacity,
    :best_chain,
    :banner_image
  ]

  defstruct [
    :tag_image,
    :tag,
    :respect,
    :rank,
    :note,
    :name,
    :members,
    :leader_id,
    :is_enlisted,
    :id,
    :days_old,
    :co_leader_id,
    :capacity,
    :best_chain,
    :banner_image
  ]

  @type t :: %__MODULE__{
          tag_image: String.t(),
          tag: String.t(),
          respect: integer(),
          rank: Torngen.Client.Schema.FactionRank.t(),
          note: nil | String.t(),
          name: String.t(),
          members: integer(),
          leader_id: Torngen.Client.Schema.UserId.t(),
          is_enlisted: nil | boolean(),
          id: Torngen.Client.Schema.FactionId.t(),
          days_old: integer(),
          co_leader_id: Torngen.Client.Schema.UserId.t(),
          capacity: integer(),
          best_chain: integer(),
          banner_image: String.t()
        }

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      tag_image: data |> Map.get("tag_image") |> Torngen.Client.Schema.parse({:static, :string}),
      tag: data |> Map.get("tag") |> Torngen.Client.Schema.parse({:static, :string}),
      respect: data |> Map.get("respect") |> Torngen.Client.Schema.parse({:static, :integer}),
      rank:
        data
        |> Map.get("rank")
        |> Torngen.Client.Schema.parse({:ref, Torngen.Client.Schema.FactionRank}),
      note: data |> Map.get("note") |> Torngen.Client.Schema.parse({:one_of, [static: :string]}),
      name: data |> Map.get("name") |> Torngen.Client.Schema.parse({:static, :string}),
      members: data |> Map.get("members") |> Torngen.Client.Schema.parse({:static, :integer}),
      leader_id:
        data
        |> Map.get("leader_id")
        |> Torngen.Client.Schema.parse({:ref, Torngen.Client.Schema.UserId}),
      is_enlisted:
        data
        |> Map.get("is_enlisted")
        |> Torngen.Client.Schema.parse({:one_of, [static: :null, static: :boolean]}),
      id:
        data
        |> Map.get("id")
        |> Torngen.Client.Schema.parse({:ref, Torngen.Client.Schema.FactionId}),
      days_old: data |> Map.get("days_old") |> Torngen.Client.Schema.parse({:static, :integer}),
      co_leader_id:
        data
        |> Map.get("co_leader_id")
        |> Torngen.Client.Schema.parse({:ref, Torngen.Client.Schema.UserId}),
      capacity: data |> Map.get("capacity") |> Torngen.Client.Schema.parse({:static, :integer}),
      best_chain:
        data |> Map.get("best_chain") |> Torngen.Client.Schema.parse({:static, :integer}),
      banner_image:
        data |> Map.get("banner_image") |> Torngen.Client.Schema.parse({:static, :string})
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

  defp validate_key?(:tag_image, value) do
    Torngen.Client.Schema.validate?(value, {:static, :string})
  end

  defp validate_key?(:tag, value) do
    Torngen.Client.Schema.validate?(value, {:static, :string})
  end

  defp validate_key?(:respect, value) do
    Torngen.Client.Schema.validate?(value, {:static, :integer})
  end

  defp validate_key?(:rank, value) do
    Torngen.Client.Schema.validate?(value, {:ref, Torngen.Client.Schema.FactionRank})
  end

  defp validate_key?(:note, value) do
    Torngen.Client.Schema.validate?(value, {:static, :string})
  end

  defp validate_key?(:name, value) do
    Torngen.Client.Schema.validate?(value, {:static, :string})
  end

  defp validate_key?(:members, value) do
    Torngen.Client.Schema.validate?(value, {:static, :integer})
  end

  defp validate_key?(:leader_id, value) do
    Torngen.Client.Schema.validate?(value, {:ref, Torngen.Client.Schema.UserId})
  end

  defp validate_key?(:is_enlisted, value) do
    Torngen.Client.Schema.validate?(value, {:one_of, [static: :null, static: :boolean]})
  end

  defp validate_key?(:id, value) do
    Torngen.Client.Schema.validate?(value, {:ref, Torngen.Client.Schema.FactionId})
  end

  defp validate_key?(:days_old, value) do
    Torngen.Client.Schema.validate?(value, {:static, :integer})
  end

  defp validate_key?(:co_leader_id, value) do
    Torngen.Client.Schema.validate?(value, {:ref, Torngen.Client.Schema.UserId})
  end

  defp validate_key?(:capacity, value) do
    Torngen.Client.Schema.validate?(value, {:static, :integer})
  end

  defp validate_key?(:best_chain, value) do
    Torngen.Client.Schema.validate?(value, {:static, :integer})
  end

  defp validate_key?(:banner_image, value) do
    Torngen.Client.Schema.validate?(value, {:static, :string})
  end

  @spec keys() :: list(atom())
  def keys(), do: @keys
end
