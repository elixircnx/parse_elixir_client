defmodule ParseClient.RequestsTest do
  use ExUnit.Case
  alias ParseClient.Requests

  test "invalid json" do
    resp = Requests.process_response_body(["not valid"])
    assert resp == "An error has occurred while processing the json response"
  end
end
