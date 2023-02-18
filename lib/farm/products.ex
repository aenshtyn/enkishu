defmodule Farm.Products do
  @moduledoc """
  The Products context.
  """

  import Ecto.Query, warn: false
  alias Farm.Repo
  alias Farm.Animals.Cow
  alias Farm.Products.Milk

  @doc """
  Returns the list of milks.

  ## Examples

      iex> list_milks()
      [%Milk{}, ...]

  """

  # def list_milks(cow) do
  #   # from(m in Milk, where: [cow_id: ^cow.id], order_by: [asc: :id])
  #   # |> Repo.all()

  #   # Repo.all(Milk)
  # end

  # def list_milks(cow) do
  #   Milk
  #   # |> Repo.all()
  #   # |> Repo.preload :cow

  #   Repo.all(Milk)
  # end

  def list_milks(cow) do
    Repo.all(Milk)
    # Repo.preload(:cows)
  end

  @doc """
  Gets a single milk.

  Raises `Ecto.NoResultsError` if the Milk does not exist.

  ## Examples

      iex> get_milk!(123)
      %Milk{}p[]

      iex> get_milk!(456)
      ** (Ecto.NoResultsError)

  """

  def get_milk!(cow_id), do: Repo.get!(Milk, cow_id)

  # def get_milk!(cow, id), do: Repo.get_by!(Milk, cow_id: cow.id, id: id)

  @doc """
  Creates a milk.

  ## Examples

  iex> create_milk(%{field: value})
  {:ok, %Milk{}}

  iex> create_milk(%{field: bad_value})
  {:error, %Ecto.Changeset{}}

  """
  def create_milk(attrs \\ %{}) do
    %Milk{}
    # |> Ecto.build_assoc(:milks)
    |> Milk.changeset(attrs)
    |> Repo.insert()
  end

  # def create_milk(cow, attrs \\ %{}) do
  #   %Cow{}
  #   |> Ecto.build_assoc(:milks, cow)
  #   |> Milk.changeset(attrs)
  #   |> Repo.insert()
  # end

  @doc """
  Updates a milk.

  ## Examples

      iex> update_milk(milk, %{field: new_value})
      {:ok, %Milk{}}

      iex> update_milk(milk, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_milk(%Milk{} = milk, attrs) do
    milk
    |> Milk.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a milk.

  ## Examples

      iex> delete_milk(milk)
      {:ok, %Milk{}}

      iex> delete_milk(milk)
      {:error, %Ecto.Changeset{}}

  """
  def delete_milk(%Milk{} = milk) do
    Repo.delete(milk)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking milk changes.

  ## Examples

      iex> change_milk(milk)
      %Ecto.Changeset{data: %Milk{}}

  """
  def change_milk(%Milk{} = milk, attrs \\ %{}) do
    Milk.changeset(milk, attrs)
  end
end
