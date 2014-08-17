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
  Code for get requests.
  Args:
    * endpoint - string requested API endpoint
  Returns dict
  """
  def get(endpoint, headers \\ [], options \\ []) do
    process_url(endpoint)
    |> HTTPoison.get(get_headers ++ headers, options)
    |> JSEX.decode! [{:labels, :atom}]
  end

  @doc """
  Code for post requests.
  Args:
    * endpoint - string requested API endpoint
    * body - body which is converted to JSON
  """
  def post(endpoint, body, headers \\ [], options \\ []) do
    text = JSEX.encode! body
    process_url(endpoint)
    |> HTTPoison.post(text, get_headers(true) ++ headers, options)
  end

  @doc """
  Code for put requests.
  Args:
    * endpoint - string requested API endpoint
    * body - body which is converted to JSON
  """
  def put(endpoint, body, headers \\ [], options \\ []) do
    text = JSEX.encode! body
    process_url(endpoint)
    |> HTTPoison.put(text, get_headers(true) ++ headers, options)
  end

  @doc """
  Code for delete requests.
  Args:
    * endpoint - string requested API endpoint
  """
  def delete(endpoint, headers \\ [], options \\ []) do
    process_url(endpoint)
    |> HTTPoison.post(get_headers ++ headers, options)
  end

  @doc """
  Grabs PARSE_API_KEY from system ENV
  """
  def api_key do
    System.get_env("PARSE_REST_API_KEY")
  end

  @doc """
  Grabs PARSE_APPLICATION_KEY from system ENV
  """
  def application_id do
    System.get_env("PARSE_APPLICATION_ID")
  end

  @doc """
  List of headers. It includes the
  API authentication headers.
  """
  def get_headers(json \\ false) do
    headers = ["X-Parse-Application-Id": application_id,
              "X-Parse-REST-API-Key": api_key]
    if json, do: headers = headers ++ ["Content-type": "application/json"]
  end
end
