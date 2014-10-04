defmodule ParseClient.Authenticate do
  @moduledoc """
  Handles authentication with Parse.com.

  Requires an environment config file with valid REST API key and App ID
  """

  @doc """
  Grabs parse_application_id from environment config file.

  Returns string or ArgumentError.
  """
  def config_parse_id do
    Application.get_env(:parse_client, :parse_application_id)
      |> check_config
  end

  @doc """
  Grabs parse_api_key from environment config file.

  Returns string or ArgumentError.
  """
  def config_parse_key do
    Application.get_env(:parse_client, :parse_api_key)
      |> check_config
  end

  defp check_config(nil) do
    raise ArgumentError, message: "Authentication failed. Add API key and App ID to config files."
  end
  defp check_config(config_variable), do: config_variable
end
