defmodule ParseClient.ConfigTest do
  use ExUnit.Case, async: true

  import ParseClient.Authenticate

  test "returns parse_application_id" do
    Application.put_env(:parse_client, :parse_application_id, "123")
    assert config_parse_id == "123"

    Application.put_env(:parse_client, :parse_application_id, nil)
  end

  test "returns parse_api_key" do
    Application.put_env(:parse_client, :parse_api_key, "456")
    assert config_parse_key == "456"

    Application.put_env(:parse_client, :parse_api_key, nil)
  end

  test "returns ArgumentError when environment variable is nil" do
    assert_raise ArgumentError, "Please add your Parse.com environment variables to ParseClient config.", fn ->
      config_parse_id
    end
  end
end
