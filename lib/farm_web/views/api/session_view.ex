defmodule FarmWeb.Api.SessionView do
  use FarmWeb, :view

  def render("create.json", %{user: user, jwt: jwt}) do
    %{
      status: :ok,
      data: %{
        token: jwt,
        username: user.username,
        email: user.email
      },
      message: "You have successfully signed in with email:" <> " " <> user.email
    }
  end

  def render("error.json", %{message: message}) do
    %{
      status: :not_found,
      data: %{},
      message: message
    }
  end
end
