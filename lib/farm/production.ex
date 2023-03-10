defmodule Farm.Production do
  @moduledoc """
  The Production context.
  """

  import Ecto.Query, warn: false
  alias Farm.Repo

  alias Farm.Production.Crop

  @doc """
  Returns the list of crops.

  ## Examples

      iex> list_crops()
      [%Crop{}, ...]

  """
  def list_crops (opts \\ []) do
    preloads = Keyword.get(opts, :preloads, [])
    Crop
    |> Repo.all()
    |> Repo.preload(preloads)
  end

  @doc """
  Gets a single crop.

  Raises `Ecto.NoResultsError` if the Crop does not exist.

  ## Examples

      iex> get_crop!(123)
      %Crop{}

      iex> get_crop!(456)
      ** (Ecto.NoResultsError)

  """
  def get_crop!(id), do: Repo.get!(Crop, id)|> Repo.preload([:paddock])

  @doc """
  Creates a crop.

  ## Examples

      iex> create_crop(%{field: value})
      {:ok, %Crop{}}

      iex> create_crop(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_crop(attrs \\ %{}) do
    %Crop{}
    |> Crop.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a crop.

  ## Examples

      iex> update_crop(crop, %{field: new_value})
      {:ok, %Crop{}}

      iex> update_crop(crop, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_crop(%Crop{} = crop, attrs) do
    crop
    |> Crop.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a crop.

  ## Examples

      iex> delete_crop(crop)
      {:ok, %Crop{}}

      iex> delete_crop(crop)
      {:error, %Ecto.Changeset{}}

  """
  def delete_crop(%Crop{} = crop) do
    Repo.delete(crop)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking crop changes.

  ## Examples

      iex> change_crop(crop)
      %Ecto.Changeset{data: %Crop{}}

  """
  def change_crop(%Crop{} = crop, attrs \\ %{}) do
    Crop.changeset(crop, attrs)
  end
end
