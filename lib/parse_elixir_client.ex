defmodule ParseClient do
  @moduledoc """
  REST API client for Parse

  ## Example usage

  To get information about a class:

      ParseClient.get("classes/Lumberjacks")

  This command prints out the whole response.
  To just see the body, run the following command:

      ParseClient.query("classes/Lumberjacks")

  To create a new object:

      body = %{"animal" => "parrot, "name" => "NorwegianBlue", "status" => 0}
      ParseClient.post("classes/Animals", body)

  To update an object:

      ParseClient.put("classes/Animals/12345678", %{"status" => 1})

  To delete an object:

      ParseClient.delete("classes/Animals/12345678")

  ## Use of filters when making queries

  The following command will check for Animals that have a status of 1:

      ParseClient.query("classes/Animals", %{"status" => 1})

  And this command will do the same check and print the results in the order
  that the items were created (use `-createdAt` to view the results in
  descending order):

      ParseClient.query("classes/Animals", %{"status" => 1}, %{"order" => "createdAt"})

  To view all results in the order that they were created, use an empty map
  as the second argument:

      ParseClient.query("classes/Animals", %{}, %{"order" => "createdAt"})
  """

  alias ParseClient.Requests

  def get(url), do: Requests.request(:get, url, "", get_headers)

  def get(url, filters, options \\ %{}), do: Requests.get(url, filters, options, get_headers)

  def post(url, body), do: Requests.request(:post, url, body, post_headers)

  def put(url, body), do: Requests.request(:put, url, body, post_headers)

  def delete(url), do: Requests.request(:delete, url, "", get_headers)

  def query(url), do: get(url).body

  def query(url, filters, options \\ %{}) do
    Requests.get(url, filters, options, get_headers).body
  end

  @doc """
  Grabs PARSE_APPLICATION_ID and PARSE_API_KEY from system ENV
  Returns key or ArgumentError
  ## Examples
      iex> System.put_env("TEST_VARIABLE", "elixir_parse_test")
      iex> ParseClient.get_system_variable("TEST_VARIABLE")
      "elixir_parse_test"

      iex> System.delete_env("TEST_VARIABLE")
      iex> ParseClient.get_system_variable("TEST_VARIABLE")
      ** (ArgumentError) parse system variable not set
  """
  def get_system_variable(variable) do
    System.get_env(variable)
      |> check_variable
  end

  defp check_variable(nil) do
    raise ArgumentError, message: "parse system variable not set"
  end

  defp check_variable(system_variable), do: system_variable

  @doc """
  Headers for get and delete requests
  """
  def get_headers do
    %{"X-Parse-Application-Id" => get_system_variable("PARSE_APPLICATION_ID"),
      "X-Parse-REST-API-Key"   => get_system_variable("PARSE_REST_API_KEY")}
  end

  @doc """
  Headers for post and put requests
  """
  def post_headers do
    Dict.put(get_headers, "Content-Type", "application/json")
  end
end
