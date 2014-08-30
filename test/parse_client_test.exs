defmodule ParseClientTest do
  use ExUnit.Case, async: true

  import ParseClient

  test "returns a defined system variable" do
    System.put_env("DEFINED_VARIABLE", "elixir_parse_test")

    assert get_system_variable("DEFINED_VARIABLE") == "elixir_parse_test"

    System.delete_env("DEFINED_VARIABLE")
  end

  test "returns ArgumentError for undefined system variable" do
    assert_raise ArgumentError, "parse system variable not set", fn ->
      get_system_variable("UNDEFINED_VARIABLE")
    end
  end
end
