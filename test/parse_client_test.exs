defmodule ParseClientTest do
  use ExUnit.Case, async: true

  import ParseClient

  test "returns a defined system variable" do
    System.put_env("TEST_VARIABLE", "elixir_parse_test")

    assert get_system_variable("TEST_VARIABLE") == "elixir_parse_test"
  end

  test "returns ArgumentError for undefined system variable" do
    System.delete_env("TEST_VARIABLE")

    assert_raise ArgumentError, "parse system variable not set", fn ->
      get_system_variable("TEST_VARIABLE")
    end
  end
end
