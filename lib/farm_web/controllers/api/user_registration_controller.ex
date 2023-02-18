defmodule FarmWeb.Api.UserRegistrationController do
  use FarmWeb, :controller

  alias Farm.Accounts
  alias Farm.Accounts.User

  # def register(conn, %{"user" => user_params}) do
  #   with [:ok, user] <- Accounts.register_user(user_params) do
  #     conn
  #     |> put_status(:created)
  #     |> text("User created successfully with email:" <> " " <> user.email)
  #   end
  # end

  def register(conn, user_params) do
    with [:ok, user] <- Accounts.register_user(user_params) do
      conn
      |> put_status(:created)
      |> json("User created successfully with email:" <> " " <> user.email)
    else
      _ -> json(conn, %{message: "Error encountered", status: "error"})
    end
  end
end
