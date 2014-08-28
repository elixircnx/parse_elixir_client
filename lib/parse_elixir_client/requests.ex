defmodule ParseClient.Requests do
  @moduledoc """
  Handles the requests for ParseClient
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
      iex> ParseClient.Requests.process_url(endpoint)
      "https://api.parse.com/1/classes/GameScore"
  """
  def process_url(endpoint) do
    @parse_url <> endpoint
  end

  @doc """
  Encodes the body and raises an error if it cannot be encoded
  ## Example
      iex> body = %{"job" => "Lumberjack", "clothes" => "stockings"}
      iex> ParseClient.Requests.process_request_body(body)
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
      iex> ParseClient.Requests.process_response_body(body)
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
  Get request with filters.

  Filters is a map that is used to make a `where={}` query.
  Options is also a map. Options include "order", "limit", "count" and "include".

  To make a request with options, but no filters, use %{} as the second argument:

      ParseClient.get("classes/Animals", %{}, %{"order" => "createdAt"})
  """
  def get(url, filters, options, headers) do
    filter_string = parse_filters(filters, options)
    request(:get, url <> "?" <> filter_string, "", headers)
  end
end
