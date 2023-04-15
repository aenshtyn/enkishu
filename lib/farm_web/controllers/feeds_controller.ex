defmodule FarmWeb.FeedsController do
  use FarmWeb, :controller

  alias Farm.Production
  alias Farm.Production.Feeds

  def index(conn, _params) do
    feeds = Production.list_feeds()
    render(conn, "index.html", feeds: feeds)
  end

  def new(conn, _params) do
    changeset = Production.change_feeds(%Feeds{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"feeds" => feeds_params}) do
    case Production.create_feeds(feeds_params) do
      {:ok, feeds} ->
        conn
        |> put_flash(:info, "Feeds created successfully.")
        |> redirect(to: Routes.feeds_path(conn, :show, feeds))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    feeds = Production.get_feeds!(id)
    render(conn, "show.html", feeds: feeds)
  end

  def edit(conn, %{"id" => id}) do
    feeds = Production.get_feeds!(id)
    changeset = Production.change_feeds(feeds)
    render(conn, "edit.html", feeds: feeds, changeset: changeset)
  end

  def update(conn, %{"id" => id, "feeds" => feeds_params}) do
    feeds = Production.get_feeds!(id)

    case Production.update_feeds(feeds, feeds_params) do
      {:ok, feeds} ->
        conn
        |> put_flash(:info, "Feeds updated successfully.")
        |> redirect(to: Routes.feeds_path(conn, :show, feeds))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", feeds: feeds, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    feeds = Production.get_feeds!(id)
    {:ok, _feeds} = Production.delete_feeds(feeds)

    conn
    |> put_flash(:info, "Feeds deleted successfully.")
    |> redirect(to: Routes.feeds_path(conn, :index))
  end
end
