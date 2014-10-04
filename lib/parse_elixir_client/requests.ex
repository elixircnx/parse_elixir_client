defmodule ParseClient.Requests do
  @moduledoc """
  Handles the requests for ParseClient.

  Uses HTTPoison.
  """

  use HTTPoison.Base
  alias ParseClient.Authenticate, as: Auth

  @parse_url "https://api.parse.com/1/"

  @doc """
  Creates the URL for an endpoint (query).

  ## Example

      iex> endpoint = "classes/GameScore"
      ...> ParseClient.Requests.process_url(endpoint)
      "https://api.parse.com/1/classes/GameScore"
  """
  def process_url(endpoint) do
    @parse_url <> endpoint
  end

  @doc """
  Encodes the body and raises an error if it cannot be encoded.

  ## Example

      iex> body = %{"job" => "Lumberjack", "clothes" => "stockings"}
      ...> ParseClient.Requests.process_request_body(body)
      ~S({\"clothes\":\"stockings\",\"job\":\"Lumberjack\"})
  """
  def process_request_body(body), do: JSEX.encode! body

  @doc """
  Checks that the body can be decoded and handles any errors.
  Converts binary response keys to atoms.

  ## Example

      iex> body = ~S({\"score\":42,\"objectId\":\"sOxpug2373\",\"playerName\":\"Tommy\"})
      ...> ParseClient.Requests.process_response_body(body)
      %{score: 42, objectId: "sOxpug2373", playerName: "Tommy"}
  """
  def process_response_body(body) do
    case JSEX.decode(body, [{:labels, :atom}]) do
      {:ok, text} -> text
      {:error, _} -> "An error has occurred while processing the json response"
    end
  end

  @doc """
  Parse filters and options in the query.

  Filters is a map that is used to make a `where={}` query.
  Options is also a map. Options include "order", "limit", "count" and "include".
  """
  def parse_filters(filters, options) when is_map(filters) and map_size(filters) > 0 do
    %{where: JSEX.encode!(filters)} |> Dict.merge(options) |> URI.encode_query
  end

  @doc """
  Parse options in the query.
  """
  def parse_filters(_, options) when is_map(options) do
    options |> URI.encode_query
  end

  def parse_filters(_, _) do
    raise ArgumentError, message: "filters and options arguments should be maps"
  end

  @doc """
  Get request for making queries.
  """
  def get(url), do: request(:get, url, "", get_headers)

  @doc """
  Get request with filters.

  ## Examples

  To make a query just about animals that have a name and are still alive:

      ParseClient.get("classes/Animals", %{"name" => %{"$exists" => true}, "status" => 1})

  To make a request with options, but no filters, use %{} as the second argument:

      ParseClient.get("classes/Animals", %{}, %{"order" => "createdAt"})
  """
  def get(url, filters, options \\ %{}) do
    filter_string = parse_filters(filters, options)
    request :get, url <> "?" <> filter_string, "", get_headers
  end

  @doc """
  Get request for making queries. Just returns the body of the response.
  """
  def query(url), do: get(url).body

  @doc """
  Get request for making queries with filters and options.
  Just returns the body of the response.
  """
  def query(url, filters, options \\ %{}) do
    get(url, filters, options).body
  end

  @doc """
  Request to create an object.

  ## Example

      body = %{"animal" => "parrot, "name" => "NorwegianBlue", "status" => 0}
      ParseClient.post("classes/Animals", body)

  """
  def post(url, body), do: request(:post, url, body, post_headers)

  @doc """
  Request to update an object.

  ## Example

      ParseClient.put("classes/Animals/12345678", %{"status" => 1})

  """
  def put(url, body), do: request(:put, url, body, post_headers)

  @doc """
  Request to delete an object.

  ## Example

      ParseClient.delete("classes/Animals/12345678")

  """
  def delete(url), do: request(:delete, url, "", get_headers)

  @doc """
  """
  def validate(url, token_key, token_val) do
    request :get, url, "", post_headers(token_key, token_val)
  end

  @doc """
  Post request to upload a file.
  """
  def upload_file(url, contents, content_type) do
    request :post, url, contents, post_headers("Content-Type", content_type)
  end

  defp get_headers do
    %{"X-Parse-Application-Id" => Auth.config_parse_id,
      "X-Parse-REST-API-Key"   => Auth.config_parse_key}
  end

  defp post_headers(key \\ "Content-Type", val \\ "application/json") do
    Dict.put(get_headers, key, val)
  end
end
