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
end
