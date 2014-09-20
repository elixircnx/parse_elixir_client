defmodule ParseClient.Authenticate do

  @doc """
  Grabs parse_application_id from environment config file.
  Returns string or ArgumentError.
  """
  def config_parse_id do
    Application.get_env(:parse_client, :parse_application_id)
      |> check_variable
  end

  @doc """
  Grabs parse_api_key from environment config file.
  Returns string or ArgumentError.
  """
  def config_parse_key do
    Application.get_env(:parse_client, :parse_api_key)
      |> check_variable
  end

  defp check_variable(nil) do
    raise ArgumentError, message: "Please add your Parse.com environment variables to ParseClient config."
  end

  defp check_variable(env_variable), do: env_variable
end
