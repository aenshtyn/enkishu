defmodule Farm.Land do
  @moduledoc """
  The Land context.
  """

  import Ecto.Query, warn: false
  alias Farm.Repo

  alias Farm.Land.Paddock

  @doc """
  Returns the list of paddocks.

  ## Examples

      iex> list_paddocks()
      [%Paddock{}, ...]

  """
  def list_paddocks do
    Repo.all(Paddock)
  end

  @doc """
  Gets a single paddock.

  Raises `Ecto.NoResultsError` if the Paddock does not exist.

  ## Examples

      iex> get_paddock!(123)
      %Paddock{}

      iex> get_paddock!(456)
      ** (Ecto.NoResultsError)

  """
  def get_paddock!(id), do: Repo.get!(Paddock, id)

  @doc """
  Creates a paddock.

  ## Examples

      iex> create_paddock(%{field: value})
      {:ok, %Paddock{}}

      iex> create_paddock(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_paddock(attrs \\ %{}) do
    %Paddock{}
    |> Paddock.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a paddock.

  ## Examples

      iex> update_paddock(paddock, %{field: new_value})
      {:ok, %Paddock{}}

      iex> update_paddock(paddock, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_paddock(%Paddock{} = paddock, attrs) do
    paddock
    |> Paddock.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a paddock.

  ## Examples

      iex> delete_paddock(paddock)
      {:ok, %Paddock{}}

      iex> delete_paddock(paddock)
      {:error, %Ecto.Changeset{}}

  """
  def delete_paddock(%Paddock{} = paddock) do
    Repo.delete(paddock)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking paddock changes.

  ## Examples

      iex> change_paddock(paddock)
      %Ecto.Changeset{data: %Paddock{}}

  """
  def change_paddock(%Paddock{} = paddock, attrs \\ %{}) do
    Paddock.changeset(paddock, attrs)
  end

  alias Farm.Land.Arable

  @doc """
  Returns the list of arable.

  ## Examples

      iex> list_arable()
      [%Arable{}, ...]

  """
  def list_arable do
    Repo.all(Arable)
  end

  @doc """
  Gets a single arable.

  Raises `Ecto.NoResultsError` if the Arable does not exist.

  ## Examples

      iex> get_arable!(123)
      %Arable{}

      iex> get_arable!(456)
      ** (Ecto.NoResultsError)

  """
  def get_arable!(id), do: Repo.get!(Arable, id)

  @doc """
  Creates a arable.

  ## Examples

      iex> create_arable(%{field: value})
      {:ok, %Arable{}}

      iex> create_arable(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_arable(attrs \\ %{}) do
    %Arable{}
    |> Arable.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a arable.

  ## Examples

      iex> update_arable(arable, %{field: new_value})
      {:ok, %Arable{}}

      iex> update_arable(arable, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_arable(%Arable{} = arable, attrs) do
    arable
    |> Arable.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a arable.

  ## Examples

      iex> delete_arable(arable)
      {:ok, %Arable{}}

      iex> delete_arable(arable)
      {:error, %Ecto.Changeset{}}

  """
  def delete_arable(%Arable{} = arable) do
    Repo.delete(arable)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking arable changes.

  ## Examples

      iex> change_arable(arable)
      %Ecto.Changeset{data: %Arable{}}

  """
  def change_arable(%Arable{} = arable, attrs \\ %{}) do
    Arable.changeset(arable, attrs)
  end
end
