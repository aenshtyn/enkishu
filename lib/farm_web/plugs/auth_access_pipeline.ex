defmodule FarmWeb.AuthAccessPipeline do
  use Guardian.Plug.Pipeline, otp_app: :farm

  plug Guardian.Plug.VerifyHeader, claims: %{"typ" => "access"}
  plug Guardian.Plug.EnsureAuthenticated
  plug Guardian.Plug.LoadResource, allow_blank: true
end
