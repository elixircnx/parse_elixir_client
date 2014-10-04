defmodule ParseClient.Users do
  @moduledoc """
  Handles the functions that are specifically related to users,
  that is, signing up, logging in, requesting a password reset,
  and validating the user.
  """

  alias ParseClient.Requests

  def signup(username, password, options \\ %{}) do
    data = Dict.merge(%{"username" => username, "password" => password}, options)
    Requests.post "users", data
  end

  def login(username, password) do
    Requests.get "login", %{"username" => username, "password" => password}
  end

  def request_passwd_reset(email) do
    Requests.post "requestPasswordReset", %{"email" => email}
  end

  def validate_user(session_token) do
    Requests.validate "users/me", "X-Parse-Session-Token", session_token
  end
end
