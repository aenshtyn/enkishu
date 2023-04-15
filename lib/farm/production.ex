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

  alias Farm.Production.Feeding

  @doc """
  Returns the list of feedings.

  ## Examples

      iex> list_feedings()
      [%Feeding{}, ...]

  """
  def list_feedings do
    Repo.all(Feeding)
  end

  @doc """
  Gets a single feeding.

  Raises `Ecto.NoResultsError` if the Feeding does not exist.

  ## Examples

      iex> get_feeding!(123)
      %Feeding{}

      iex> get_feeding!(456)
      ** (Ecto.NoResultsError)

  """
  def get_feeding!(id), do: Repo.get!(Feeding, id) |> Repo.preload([:feeds])

  @doc """
  Creates a feeding.

  ## Examples

      iex> create_feeding(%{field: value})
      {:ok, %Feeding{}}

      iex> create_feeding(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_feeding(attrs \\ %{}) do
    %Feeding{}
    |> Feeding.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a feeding.

  ## Examples

      iex> update_feeding(feeding, %{field: new_value})
      {:ok, %Feeding{}}

      iex> update_feeding(feeding, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_feeding(%Feeding{} = feeding, attrs) do
    feeding
    |> Feeding.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a feeding.

  ## Examples

      iex> delete_feeding(feeding)
      {:ok, %Feeding{}}

      iex> delete_feeding(feeding)
      {:error, %Ecto.Changeset{}}

  """
  def delete_feeding(%Feeding{} = feeding) do
    Repo.delete(feeding)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking feeding changes.

  ## Examples

      iex> change_feeding(feeding)
      %Ecto.Changeset{data: %Feeding{}}

  """
  def change_feeding(%Feeding{} = feeding, attrs \\ %{}) do
    Feeding.changeset(feeding, attrs)
  end

  alias Farm.Production.Feeds

  @doc """
  Returns the list of feeds.

  ## Examples

      iex> list_feeds()
      [%Feeds{}, ...]

  """
  def list_feeds (opts \\ []) do

    preloads = Keyword.get(opts, :preloads, [])
    Feeds
    |> Repo.all()
    |> Repo.preload(preloads)
  end

  @doc """
  Gets a single feeds.

  Raises `Ecto.NoResultsError` if the Feeds does not exist.

  ## Examples

      iex> get_feeds!(123)
      %Feeds{}

      iex> get_feeds!(456)
      ** (Ecto.NoResultsError)

  """
  def get_feeds!(id), do: Repo.get!(Feeds, id)

  @doc """
  Creates a feeds.

  ## Examples

      iex> create_feeds(%{field: value})
      {:ok, %Feeds{}}

      iex> create_feeds(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_feeds(attrs \\ %{}) do
    %Feeds{}
    |> Feeds.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a feeds.

  ## Examples

      iex> update_feeds(feeds, %{field: new_value})
      {:ok, %Feeds{}}

      iex> update_feeds(feeds, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_feeds(%Feeds{} = feeds, attrs) do
    feeds
    |> Feeds.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a feeds.

  ## Examples

      iex> delete_feeds(feeds)
      {:ok, %Feeds{}}

      iex> delete_feeds(feeds)
      {:error, %Ecto.Changeset{}}

  """
  def delete_feeds(%Feeds{} = feeds) do
    Repo.delete(feeds)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking feeds changes.

  ## Examples

      iex> change_feeds(feeds)
      %Ecto.Changeset{data: %Feeds{}}

  """
  def change_feeds(%Feeds{} = feeds, attrs \\ %{}) do
    Feeds.changeset(feeds, attrs)
  end
end
