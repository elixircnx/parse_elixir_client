defmodule ParseClient do
  @moduledoc """
  REST API client for Parse
  """

  use HTTPoison.Base

  @parse_url "https://api.parse.com/1/"

  @doc """
  Creates the URL for an endpoint
  Args:
    * endpoint - part of the API we're hitting
  Returns string

  ## Example
      iex> endpoint = "classes/GameScore"
      iex> ParseClient.process_url(endpoint)
      "https://api.parse.com/1/classes/GameScore"
  """
  def process_url(endpoint) do
    @parse_url <> endpoint
  end

  @doc """
  Checks that the body can be encoded and handles any errors
  """
  def process_request_body(body) do
    case JSEX.encode(body) do
      {:ok, text} -> text
      {:error, _} -> "An error has occurred while encoding into json"
    end
  end

  @doc """
  Checks that the body can be decoded and handles any errors
  Converts binary response keys to atoms
  Args:
  * body - string binary response
  Returns Record or ArgumentError
  ## Example
  iex> body = ~S({\"score\":1337,\"objectId\":\"sOxpug2373\",\"playerName\":\"Sean Plott\"})
  iex> ParseClient.process_response_body(body)
  %{score: 1337, objectId: "sOxpug2373", playerName: "Sean Plott"}
  """
  def process_response_body(body) do
    case JSEX.decode(body, [{:labels, :atom}]) do
      {:ok, text} -> text
      {:error, _} -> "An error has occurred while processing the json response"
    end
  end

  @doc """
  Add headers for requests
  """
  def process_request_headers(_) do
    Enum.into get_headers, []
  end

  @doc """
  Grabs PARSE_API_KEY from system ENV
  """
  def api_key do
    System.get_env "PARSE_REST_API_KEY"
  end

  @doc """
  Grabs PARSE_APPLICATION_KEY from system ENV
  """
  def application_id do
    System.get_env "PARSE_APPLICATION_ID"
  end

  @doc """
  Sets PARSE_API_KEY
  """
  def set_api_key(api_key) do
    System.put_env "PARSE_REST_API_KEY", api_key
  end

  @doc """
  Sets PARSE_APPLICATION_KEY
  """
  def set_application_id(app_id) do
    System.put_env "PARSE_APPLICATION_ID", app_id
  end

  @doc """
  Lists of headers which include the
  API authentication headers
  """
  def get_headers do
    %{"X-Parse-Application-Id" => application_id,
      "X-Parse-REST-API-Key" => api_key}
  end

  def post_headers do
      Dict.put(get_headers, "Content-Type", "application/json")
  end
end
