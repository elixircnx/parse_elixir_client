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

      ParseClient.get("classes/Animals", %{"status" => 1})

  And this command will do the same check and print the results in the order
  that the items were created (use `-createdAt` to view the results in
  descending order):

      ParseClient.get("classes/Animals", %{"status" => 1}, %{"order" => "createdAt"})
  """

  alias ParseClient.Requests

  @doc """
  Parse filters and options in the query when both are maps.
  """
  def parse_filters(filters, options) when is_map(filters) and is_map(options) do
    Dict.merge(%{where: JSEX.encode!(filters)}, options)
    |> URI.encode_query
  end

  @doc """
  Parse filters and options in the query.
  """
  def parse_filters(filters, options) do
    unless filters == "", do: filters = %{where: JSEX.encode!(filters)} |> URI.encode_query
    unless options == "", do: options = options |> URI.encode_query
    filters <> options
  end

  def get(url), do: Requests.request(:get, url, "", get_headers)

  @doc """
  Get request with filters.

  Filters is a map that is used to make a `where={}` query.
  Options is also a map. Options include "order", "limit", "count" and "include".

  To make a request with options, but no filters, use "" as the second argument:

      ParseClient.get("classes/Animals", "", %{"order" => "createdAt"})
  """
  def get(url, filters, options \\ "") do
    filter_string = parse_filters(filters, options)
    Requests.request(:get, url <> "?" <> filter_string, "", get_headers)
  end

  def post(url, body), do: Requests.request(:post, url, body, post_headers)

  def put(url, body), do: Requests.request(:put, url, body, post_headers)

  def delete(url), do: Requests.request(:delete, url, "", get_headers)

  def query(url), do: get(url).body

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
