defmodule Farm.Finance do
  @moduledoc """
  The Finance context.
  """

  import Ecto.Query, warn: false
  alias Farm.Repo

  alias Farm.Finance.Sales

  @doc """
  Returns the list of sales.

  ## Examples

      iex> list_sales()
      [%Sales{}, ...]

  """
  def list_sales do
    Repo.all(Sales)
  end

  @doc """
  Gets a single sales.

  Raises `Ecto.NoResultsError` if the Sales does not exist.

  ## Examples

      iex> get_sales!(123)
      %Sales{}

      iex> get_sales!(456)
      ** (Ecto.NoResultsError)

  """
  def get_sales!(id), do: Repo.get!(Sales, id)

  @doc """
  Creates a sales.

  ## Examples

      iex> create_sales(%{field: value})
      {:ok, %Sales{}}

      iex> create_sales(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_sales(attrs \\ %{}) do
    %Sales{}
    |> Sales.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a sales.

  ## Examples

      iex> update_sales(sales, %{field: new_value})
      {:ok, %Sales{}}

      iex> update_sales(sales, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_sales(%Sales{} = sales, attrs) do
    sales
    |> Sales.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a sales.

  ## Examples

      iex> delete_sales(sales)
      {:ok, %Sales{}}

      iex> delete_sales(sales)
      {:error, %Ecto.Changeset{}}

  """
  def delete_sales(%Sales{} = sales) do
    Repo.delete(sales)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking sales changes.

  ## Examples

      iex> change_sales(sales)
      %Ecto.Changeset{data: %Sales{}}

  """
  def change_sales(%Sales{} = sales, attrs \\ %{}) do
    Sales.changeset(sales, attrs)
  end

  alias Farm.Finance.Procurement

  @doc """
  Returns the list of procurement.

  ## Examples

      iex> list_procurement()
      [%Procurement{}, ...]

  """
  def list_procurements do
    Repo.all(Procurement)
  end

  @doc """
  Gets a single procurement.

  Raises `Ecto.NoResultsError` if the Procurement does not exist.

  ## Examples

      iex> get_procurement!(123)
      %Procurement{}

      iex> get_procurement!(456)
      ** (Ecto.NoResultsError)

  """
  def get_procurement!(id), do: Repo.get!(Procurement, id)

  @doc """
  Creates a procurement.

  ## Examples

      iex> create_procurement(%{field: value})
      {:ok, %Procurement{}}

      iex> create_procurement(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_procurement(attrs \\ %{}) do
    %Procurement{}
    |> Procurement.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a procurement.

  ## Examples

      iex> update_procurement(procurement, %{field: new_value})
      {:ok, %Procurement{}}

      iex> update_procurement(procurement, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_procurement(%Procurement{} = procurement, attrs) do
    procurement
    |> Procurement.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a procurement.

  ## Examples

      iex> delete_procurement(procurement)
      {:ok, %Procurement{}}

      iex> delete_procurement(procurement)
      {:error, %Ecto.Changeset{}}

  """
  def delete_procurement(%Procurement{} = procurement) do
    Repo.delete(procurement)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking procurement changes.

  ## Examples

      iex> change_procurement(procurement)
      %Ecto.Changeset{data: %Procurement{}}

  """
  def change_procurement(%Procurement{} = procurement, attrs \\ %{}) do
    Procurement.changeset(procurement, attrs)
  end

  alias Farm.Finance.Salary

  @doc """
  Returns the list of salarys.

  ## Examples

      iex> list_salarys()
      [%Salary{}, ...]

  """
  def list_salarys do
    Repo.all(Salary)
  end

  @doc """
  Gets a single salary.

  Raises `Ecto.NoResultsError` if the Salary does not exist.

  ## Examples

      iex> get_salary!(123)
      %Salary{}

      iex> get_salary!(456)
      ** (Ecto.NoResultsError)

  """
  def get_salary!(id), do: Repo.get!(Salary, id)

  @doc """
  Creates a salary.

  ## Examples

      iex> create_salary(%{field: value})
      {:ok, %Salary{}}

      iex> create_salary(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_salary(attrs \\ %{}) do
    %Salary{}
    |> Salary.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a salary.

  ## Examples

      iex> update_salary(salary, %{field: new_value})
      {:ok, %Salary{}}

      iex> update_salary(salary, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_salary(%Salary{} = salary, attrs) do
    salary
    |> Salary.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a salary.

  ## Examples

      iex> delete_salary(salary)
      {:ok, %Salary{}}

      iex> delete_salary(salary)
      {:error, %Ecto.Changeset{}}

  """
  def delete_salary(%Salary{} = salary) do
    Repo.delete(salary)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking salary changes.

  ## Examples

      iex> change_salary(salary)
      %Ecto.Changeset{data: %Salary{}}

  """
  def change_salary(%Salary{} = salary, attrs \\ %{}) do
    Salary.changeset(salary, attrs)
  end
end
