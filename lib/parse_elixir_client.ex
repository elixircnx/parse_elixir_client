defmodule ParseClient do
  @moduledoc """
  REST API client for Parse
  """

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
  Checks that the body can be decoded and handles any errors
  Converts binary response keys to atoms
  Args:
  * body - string binary response
  Returns Record or ArgumentError
  ## Example
  iex> body = ~S({\"score\":1337,\"objectId\":\"sOxpug2373\",\"playerName\":\"Sean Plott\"})
  iex> ParseElixirClient.process_body(body)
  %{score: 1337, objectId: "sOxpug2373", playerName: "Sean Plott"}
  """
  def process_body(json_body) do
    case JSEX.decode(json_body, [{:labels, :atom}]) do
      {:ok, text} -> text
      {:error, error} -> error
    end
  end

  @doc """
  Code for get requests
  Args:
    * endpoint - string requested API endpoint
  Returns dict
  """
  def get(endpoint) do
    HTTPoison.get(process_url(endpoint), get_headers).body
    |> process_body
  end

  @doc """
  Code for post requests
  Args:
    * endpoint - string requested API endpoint
    * body - body which is converted to JSON
  """
  def post(endpoint, body) do
    text = JSEX.encode! body
    process_url(endpoint)
    |> HTTPoison.post text, post_headers
  end

  @doc """
  Code for put requests
  Args:
    * endpoint - string requested API endpoint
    * body - body which is converted to JSON
  """
  def put(endpoint, body) do
    text = JSEX.encode! body
    process_url(endpoint)
    |> HTTPoison.put text, post_headers
  end

  @doc """
  Code for delete requests
  Args:
    * endpoint - string requested API endpoint
  """
  def delete(endpoint) do
    process_url(endpoint)
    |> HTTPoison.delete get_headers
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
  The following two functions let you set
  the environment values
  """
  def set_api_key(api_key) do
    System.put_env "PARSE_REST_API_KEY", api_key
  end

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
