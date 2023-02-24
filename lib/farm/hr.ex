defmodule Farm.HR do
  @moduledoc """
  The HR context.
  """

  import Ecto.Query, warn: false
  alias Farm.Repo

  alias Farm.HR.Worker
  alias Farm.Hr.Role
  alias Farm.Hr.Patron

  @doc """
  Returns the list of workers.

  ## Examples

      iex> list_workers()
      [%Worker{}, ...]

  """
  def list_workers(roles) do
    Repo.all(Worker)
  end

  @doc """
  Gets a single worker.

  Raises `Ecto.NoResultsError` if the Worker does not exist.

  ## Examples

      iex> get_worker!(123)
      %Worker{}

      iex> get_worker!(456)
      ** (Ecto.NoResultsError)

  """
  def get_worker!(role_id), do: Repo.get!(Worker, role_id)

  @doc """
  Creates a worker.

  ## Examples

      iex> create_worker(%{field: value})
      {:ok, %Worker{}}

      iex> create_worker(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_worker(attrs \\ %{}) do
    %Worker{}
    |> Worker.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a worker.

  ## Examples

      iex> update_worker(worker, %{field: new_value})
      {:ok, %Worker{}}

      iex> update_worker(worker, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_worker(%Worker{} = worker, attrs) do
    worker
    |> Worker.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a worker.

  ## Examples

      iex> delete_worker(worker)
      {:ok, %Worker{}}

      iex> delete_worker(worker)
      {:error, %Ecto.Changeset{}}

  """
  def delete_worker(%Worker{} = worker) do
    Repo.delete(worker)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking worker changes.

  ## Examples

      iex> change_worker(worker)
      %Ecto.Changeset{data: %Worker{}}

  """
  def change_worker(%Worker{} = worker, attrs \\ %{}) do
    Worker.changeset(worker, attrs)
  end

  alias Farm.HR.Patron

  @doc """
  Returns the list of patrons.

  ## Examples

      iex> list_patrons()
      [%Patron{}, ...]

  """
  def list_patrons(opts \\ []) do

    preloads = Keyword.get(opts, :preloads, [])

    Patron
    |> Repo.all()
    |> Repo.preload(preloads)
  end

  @doc """
  Gets a single patron.

  Raises `Ecto.NoResultsError` if the Patron does not exist.

  ## Examples

      iex> get_patron!(123)
      %Patron{}

      iex> get_patron!(456)
      ** (Ecto.NoResultsError)

  """
  def get_patron!(role_id), do: Repo.get!(Patron, role_id)

  @doc """
  Creates a patron.

  ## Examples

      iex> create_patron(%{field: value})
      {:ok, %Patron{}}

      iex> create_patron(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_patron(attrs \\ %{}) do
    %Patron{}
    |> Patron.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a patron.

  ## Examples

      iex> update_patron(patron, %{field: new_value})
      {:ok, %Patron{}}

      iex> update_patron(patron, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_patron(%Patron{} = patron, attrs) do
    patron
    |> Patron.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a patron.

  ## Examples

      iex> delete_patron(patron)
      {:ok, %Patron{}}

      iex> delete_patron(patron)
      {:error, %Ecto.Changeset{}}

  """
  def delete_patron(%Patron{} = patron) do
    Repo.delete(patron)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking patron changes.

  ## Examples

      iex> change_patron(patron)
      %Ecto.Changeset{data: %Patron{}}

  """
  def change_patron(%Patron{} = patron, attrs \\ %{}) do
    Patron.changeset(patron, attrs)
  end

  alias Farm.HR.Role

  @doc """
  Returns the list of roles.

  ## Examples

      iex> list_roles()
      [%Role{}, ...]

  """
  def list_roles do
    Role
    |> Repo.all()

    # |> Repo.preload(:patrons)
    # |> Repo.all(:workers)
  end

  @doc """
  Gets a single role.

  Raises `Ecto.NoResultsError` if the Role does not exist.

  ## Examples

      iex> get_role!(123)
      %Role{}

      iex> get_role!(456)
      ** (Ecto.NoResultsError)

  """
  def get_role!(id), do: Repo.get!(Role, id)

  @doc """
  Creates a role.

  ## Examples

      iex> create_role(%{field: value})
      {:ok, %Role{}}

      iex> create_role(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_role(attrs \\ %{}) do
    %Role{}
    |> Role.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a role.

  ## Examples

      iex> update_role(role, %{field: new_value})
      {:ok, %Role{}}

      iex> update_role(role, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_role(%Role{} = role, attrs) do
    role
    |> Role.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a role.

  ## Examples

      iex> delete_role(role)
      {:ok, %Role{}}

      iex> delete_role(role)
      {:error, %Ecto.Changeset{}}

  """
  def delete_role(%Role{} = role) do
    Repo.delete(role)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking role changes.

  ## Examples

      iex> change_role(role)
      %Ecto.Changeset{data: %Role{}}

  """
  def change_role(%Role{} = role, attrs \\ %{}) do
    Role.changeset(role, attrs)
  end

  alias Farm.HR.Duty

  @doc """
  Returns the list of duties.

  ## Examples

      iex> list_duties()
      [%Duty{}, ...]

  """
  def list_duties do
    Repo.all(Duty)
  end

  @doc """
  Gets a single duty.

  Raises `Ecto.NoResultsError` if the Duty does not exist.

  ## Examples

      iex> get_duty!(123)
      %Duty{}

      iex> get_duty!(456)
      ** (Ecto.NoResultsError)

  """
  def get_duty!(id), do: Repo.get!(Duty, id)

  @doc """
  Creates a duty.

  ## Examples

      iex> create_duty(%{field: value})
      {:ok, %Duty{}}

      iex> create_duty(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_duty(attrs \\ %{}) do
    %Duty{}
    |> Duty.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a duty.

  ## Examples

      iex> update_duty(duty, %{field: new_value})
      {:ok, %Duty{}}

      iex> update_duty(duty, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_duty(%Duty{} = duty, attrs) do
    duty
    |> Duty.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a duty.

  ## Examples

      iex> delete_duty(duty)
      {:ok, %Duty{}}

      iex> delete_duty(duty)
      {:error, %Ecto.Changeset{}}

  """
  def delete_duty(%Duty{} = duty) do
    Repo.delete(duty)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking duty changes.

  ## Examples

      iex> change_duty(duty)
      %Ecto.Changeset{data: %Duty{}}

  """
  def change_duty(%Duty{} = duty, attrs \\ %{}) do
    Duty.changeset(duty, attrs)
  end
end
