defmodule Farm.Inventory do
  @moduledoc """
  The Inventory context.
  """

  import Ecto.Query, warn: false
  alias Farm.Repo

  alias Farm.Inventory.Machinery

  @doc """
  Returns the list of machinerys.

  ## Examples

      iex> list_machinerys()
      [%Machinery{}, ...]

  """
  def list_machinerys do
    Repo.all(Machinery)
  end

  @doc """
  Gets a single machinery.

  Raises `Ecto.NoResultsError` if the Machinery does not exist.

  ## Examples

      iex> get_machinery!(123)
      %Machinery{}

      iex> get_machinery!(456)
      ** (Ecto.NoResultsError)

  """
  def get_machinery!(id), do: Repo.get!(Machinery, id)

  @doc """
  Creates a machinery.

  ## Examples

      iex> create_machinery(%{field: value})
      {:ok, %Machinery{}}

      iex> create_machinery(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_machinery(attrs \\ %{}) do
    %Machinery{}
    |> Machinery.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a machinery.

  ## Examples

      iex> update_machinery(machinery, %{field: new_value})
      {:ok, %Machinery{}}

      iex> update_machinery(machinery, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_machinery(%Machinery{} = machinery, attrs) do
    machinery
    |> Machinery.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a machinery.

  ## Examples

      iex> delete_machinery(machinery)
      {:ok, %Machinery{}}

      iex> delete_machinery(machinery)
      {:error, %Ecto.Changeset{}}

  """
  def delete_machinery(%Machinery{} = machinery) do
    Repo.delete(machinery)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking machinery changes.

  ## Examples

      iex> change_machinery(machinery)
      %Ecto.Changeset{data: %Machinery{}}

  """
  def change_machinery(%Machinery{} = machinery, attrs \\ %{}) do
    Machinery.changeset(machinery, attrs)
  end

  alias Farm.Inventory.Medication

  @doc """
  Returns the list of medications.

  ## Examples

      iex> list_medications()
      [%Medication{}, ...]

  """
  def list_medications do
    Repo.all(Medication)
  end

  @doc """
  Gets a single medication.

  Raises `Ecto.NoResultsError` if the Medication does not exist.

  ## Examples

      iex> get_medication!(123)
      %Medication{}

      iex> get_medication!(456)
      ** (Ecto.NoResultsError)

  """
  def get_medication!(id), do: Repo.get!(Medication, id)

  @doc """
  Creates a medication.

  ## Examples

      iex> create_medication(%{field: value})
      {:ok, %Medication{}}

      iex> create_medication(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_medication(attrs \\ %{}) do
    %Medication{}
    |> Medication.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a medication.

  ## Examples

      iex> update_medication(medication, %{field: new_value})
      {:ok, %Medication{}}

      iex> update_medication(medication, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_medication(%Medication{} = medication, attrs) do
    medication
    |> Medication.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a medication.

  ## Examples

      iex> delete_medication(medication)
      {:ok, %Medication{}}

      iex> delete_medication(medication)
      {:error, %Ecto.Changeset{}}

  """
  def delete_medication(%Medication{} = medication) do
    Repo.delete(medication)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking medication changes.

  ## Examples

      iex> change_medication(medication)
      %Ecto.Changeset{data: %Medication{}}

  """
  def change_medication(%Medication{} = medication, attrs \\ %{}) do
    Medication.changeset(medication, attrs)
  end

  alias Farm.Inventory.Product

  @doc """
  Returns the list of products.

  ## Examples

      iex> list_products()
      [%Product{}, ...]

  """
  def list_products do
    Repo.all(Product)
  end

  @doc """
  Gets a single product.

  Raises `Ecto.NoResultsError` if the Product does not exist.

  ## Examples

      iex> get_product!(123)
      %Product{}

      iex> get_product!(456)
      ** (Ecto.NoResultsError)

  """
  def get_product!(id), do: Repo.get!(Product, id)

  @doc """
  Creates a product.

  ## Examples

      iex> create_product(%{field: value})
      {:ok, %Product{}}

      iex> create_product(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_product(attrs \\ %{}) do
    %Product{}
    |> Product.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a product.

  ## Examples

      iex> update_product(product, %{field: new_value})
      {:ok, %Product{}}

      iex> update_product(product, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_product(%Product{} = product, attrs) do
    product
    |> Product.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a product.

  ## Examples

      iex> delete_product(product)
      {:ok, %Product{}}

      iex> delete_product(product)
      {:error, %Ecto.Changeset{}}

  """
  def delete_product(%Product{} = product) do
    Repo.delete(product)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking product changes.

  ## Examples

      iex> change_product(product)
      %Ecto.Changeset{data: %Product{}}

  """
  def change_product(%Product{} = product, attrs \\ %{}) do
    Product.changeset(product, attrs)
  end
end
