defmodule ParseClient.Authenticate do

  @doc """
  Grabs PARSE_APPLICATION_ID and PARSE_API_KEY from the system environment.
  Returns key or ArgumentError.
  """
  def get_sysvar(variable) do
    System.get_env(variable)
      |> check_variable
  end

  defp check_variable(nil) do
    raise ArgumentError, message: "Parse system variable not set."
  end

  defp check_variable(system_variable), do: system_variable

end
