defmodule ParseClient.RequestsTest do
  use ExUnit.Case
  alias ParseClient.Requests

  test "invalid json" do
    resp = Requests.process_response_body(["not valid"])
    assert resp == "An error has occurred while processing the json response"
  end

  test "parse filters" do
    resp = Requests.parse_filters(%{"name" => "Bob"}, %{})
    assert resp == "where=%7B%22name%22%3A%22Bob%22%7D"
  end

  test "parse filters and options" do
    resp = Requests.parse_filters(%{"name" => "Bob"}, %{"count" => 1})
    assert resp == "where=%7B%22name%22%3A%22Bob%22%7D&count=1"
  end

  test "parse options" do
    resp = Requests.parse_filters(%{}, %{"count" => 1})
    assert resp == "count=1"
  end

end
