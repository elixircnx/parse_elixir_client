defmodule ParseElixirClient do
  @moduledoc """
  REST API client for Parse
  """

  @doc """
  Creates the URL for an endpoint
  Args:
    * endpoint - part of the API we're hitting
  Returns string

  ## Example
      iex> endpoint = "classes/GameScore"
      iex> ParseElixirClient.process_url(endpoint)
      "https://api.parse.com/1/classes/GameScore.json"
  """
  def process_url(endpoint) do
    "https://api.parse.com/1/#{endpoint}" <> ".json"
  end

  @doc """
  Converts binary response keys to atoms
  Args:
    * body - string binary response
  Returns Record or ArgumentError

  ## Example
      iex> body = ~S({\"score\":1337,\"objectId\":\"sOxpug2373\",\"playerName\":\"Sean Plott\"})
      iex> ParseElixirClient.process_response_body(body)
      %{score: 1337, objectId: "sOxpug2373", playerName: "Sean Plott"}
  """
  def process_response_body(body) do
    JSEX.decode!(body, [{:labels, :atom}])
  end

  @doc """
  Boilerplate code to make requests
  Args:
    * endpoint - string requested API endpoint
    * body - request body
  Returns dict
  """
  def request(endpoint, body) do
    ParseElixirClient.post(endpoint, JSEX.encode! body).body
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
  API authentication headers
  """
  def map_header do
    %{"X-Parse-Application-Id" => application_id,
      "X-Parse-REST-API-Key"   => api_key}
  end
end
