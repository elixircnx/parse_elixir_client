defmodule ParseClient do
  @moduledoc """
  REST API client for Parse

  Example usage

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
  ## Example
      iex> body = %{"job" => "Lumberjack", "clothes" => "stockings"}
      iex> ParseClient.process_request_body(body)
      ~S({\"clothes\":\"stockings\",\"job\":\"Lumberjack\"})
  """
  def process_request_body(body), do: JSEX.encode! body

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
  Parse filters and options in the query.
  """
  def parse_filters(filters, options) do
    unless filters == "", do: filters = %{where: JSEX.encode!(filters)} |> URI.encode_query
    unless options == %{}, do: options = options |> URI.encode_query
    filters <> options
  end

  def get(url), do: request(:get, url, "", get_headers)

  @doc """
  Get request with filters.

  Filters is a map that is used to make a `where={}` query.
  Options is also a map. Options include "order", "limit", "count" and "include".

  To make a request with options, but no filters, use "" as the second argument:

      ParseClient.get("classes/Animals", "", %{"order" => "createdAt"})
  """
  def get(url, filters, options \\ %{}) do
    filter_string = parse_filters(filters, options)
    request(:get, url <> "?" <> filter_string, "", get_headers)
  end

  def post(url, body), do: request(:post, url, body, post_headers)

  def put(url, body), do: request(:put, url, body, post_headers)

  def delete(url), do: request(:delete, url, "", get_headers)

  def query(args), do: get(args).body

  def query(url, filters, options \\ []), do: get(url, filters, options).body

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
  Headers for get and delete requests
  """
  def get_headers do
    %{"X-Parse-Application-Id" => application_id,
      "X-Parse-REST-API-Key" => api_key}
  end

  @doc """
  Headers for post and put requests
  """
  def post_headers do
    Dict.put(get_headers, "Content-Type", "application/json")
  end
end
