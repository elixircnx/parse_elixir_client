defmodule ParseClientTest do
  use ExUnit.Case

  alias ParseClient, as: P

  test "invalid map" do
    req = P.process_request_body(self()) 
    assert req == "An error has occurred while encoding into json"
  end
  test "invalid json" do
    resp = P.process_response_body(["not valid"]) 
    assert resp == "An error has occurred while processing the json response"
  end
end
