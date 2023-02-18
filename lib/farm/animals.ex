defmodule Farm.Animals do
  @moduledoc """
  The Animals context.
  """

  import Ecto.Query, warn: false
  alias Farm.Repo

  alias Farm.Animals.Cow
  alias Farm.HR.Patron

  @doc """
  Returns the list of cows.

  ## Examples

      iex> list_cows()
      [%Cow{}, ...]

  """
  def list_cows(patron) do
    Cow
    |> Repo.all()
    |> Repo.preload(:milks)
    |> Repo.preload(:events)

    # Repo.all(Cow)
  end

  # def preload(data) do
  #   Repo.preload(data)
  # end

  @doc """
  Gets a single cow.

  Raises `Ecto.NoResultsError` if the Cow does not exist.

  ## Examples

      iex> get_cow!(123)
      %Cow{}

      iex> get_cow!(456)
      ** (Ecto.NoResultsError)

  """
  def get_cow!(id), do: Repo.get!(Cow, id) |> Repo.preload(:milks)

  @doc """
  Creates a cow.

  ## Examples

      iex> create_cow(%{field: value})
      {:ok, %Cow{}}

      iex> create_cow(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_cow(attrs \\ %{}) do
    %Cow{}
    |> Cow.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a cow.

  ## Examples

      iex> update_cow(cow, %{field: new_value})
      {:ok, %Cow{}}

      iex> update_cow(cow, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_cow(%Cow{} = cow, attrs) do
    cow
    |> Cow.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a cow.

  ## Examples

      iex> delete_cow(cow)
      {:ok, %Cow{}}

      iex> delete_cow(cow)
      {:error, %Ecto.Changeset{}}

  """
  def delete_cow(%Cow{} = cow) do
    Repo.delete(cow)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking cow changes.

  ## Examples

      iex> change_cow(cow)
      %Ecto.Changeset{data: %Cow{}}

  """
  def change_cow(%Cow{} = cow, attrs \\ %{}) do
    Cow.changeset(cow, attrs)
  end

  alias Farm.Animals.Sheep

  @doc """
  Returns the list of sheeps.

  ## Examples

      iex> list_sheeps()
      [%Sheep{}, ...]

  """
  def list_sheeps do
    Repo.all(Sheep)
  end

  @doc """
  Gets a single sheep.

  Raises `Ecto.NoResultsError` if the Sheep does not exist.

  ## Examples

      iex> get_sheep!(123)
      %Sheep{}

      iex> get_sheep!(456)
      ** (Ecto.NoResultsError)

  """
  def get_sheep!(id), do: Repo.get!(Sheep, id)

  @doc """
  Creates a sheep.

  ## Examples

      iex> create_sheep(%{field: value})
      {:ok, %Sheep{}}

      iex> create_sheep(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_sheep(attrs \\ %{}) do
    %Sheep{}
    |> Sheep.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a sheep.

  ## Examples

      iex> update_sheep(sheep, %{field: new_value})
      {:ok, %Sheep{}}

      iex> update_sheep(sheep, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_sheep(%Sheep{} = sheep, attrs) do
    sheep
    |> Sheep.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a sheep.

  ## Examples

      iex> delete_sheep(sheep)
      {:ok, %Sheep{}}

      iex> delete_sheep(sheep)
      {:error, %Ecto.Changeset{}}

  """
  def delete_sheep(%Sheep{} = sheep) do
    Repo.delete(sheep)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking sheep changes.

  ## Examples

      iex> change_sheep(sheep)
      %Ecto.Changeset{data: %Sheep{}}

  """
  def change_sheep(%Sheep{} = sheep, attrs \\ %{}) do
    Sheep.changeset(sheep, attrs)
  end
end
