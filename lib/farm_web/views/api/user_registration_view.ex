defmodule FarmWeb.Api.UserRegistrationView do
  use FarmWeb, :view

  def render("register.json", %{user: user}) do
    %{
      status: :ok,
      data: %{
        username: user.username,
        email: user.email
      },
      message: "You are successfully Registered"
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
