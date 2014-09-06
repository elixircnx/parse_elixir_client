defmodule ParseClient do
  @moduledoc """
  REST API client for Parse in Elixir

  ## Example usage

  To get information about a class (and print out the whole response):

      ParseClient.get("classes/Lumberjacks")

  To just see the body, use the `query` function:

      ParseClient.query("classes/Lumberjacks")

  To create a new object, use the `post` function, to update an object, use
  the `put` function, and to delete an object, use the `delete` function.

  ## Use of filters when making queries

  Queries can be filtered by using *filters* and *options*.

  Use filters when you would use `where=` clauses in a request to the Parse API.
  Options include "order", "limit", "count" and "include".

  Both filters and options need to be Elixir maps.
  """

  alias ParseClient.Requests
  alias ParseClient.Authenticate, as: Auth

  @doc """
  Get request for making queries.
  """
  def get(url), do: Requests.request(:get, url, "", get_headers)

  @doc """
  Get request for making queries. The queries can be filtered.
  """
  def get(url, filters, options \\ %{}), do: Requests.get(url, filters, options, get_headers)

  @doc """
  Request to create an object.

  ## Example

      body = %{"animal" => "parrot, "name" => "NorwegianBlue", "status" => 0}
      ParseClient.post("classes/Animals", body)

  """
  def post(url, body), do: Requests.request(:post, url, body, post_headers)

  @doc """
  Request to update an object.

  ## Example

      ParseClient.put("classes/Animals/12345678", %{"status" => 1})

  """
  def put(url, body), do: Requests.request(:put, url, body, post_headers)

  @doc """
  Request to delete an object.

  ## Example

      ParseClient.delete("classes/Animals/12345678")

  """
  def delete(url), do: Requests.request(:delete, url, "", get_headers)

  @doc """
  Get request for making queries. Just returns the body of the response.
  """
  def query(url), do: get(url).body

  @doc """
  Get request for making queries with filters and options.
  Just returns the body of the response.

  ## Examples

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
  def query(url, filters, options \\ %{}) do
    Requests.get(url, filters, options, get_headers).body
  end

  defp get_headers do
    %{"X-Parse-Application-Id" => Auth.get_sysvar("PARSE_APPLICATION_ID"),
      "X-Parse-REST-API-Key"   => Auth.get_sysvar("PARSE_REST_API_KEY")}
  end

  defp post_headers do
    Dict.put(get_headers, "Content-Type", "application/json")
  end
end
