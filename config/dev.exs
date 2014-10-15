use Mix.Config

config :parse_client,
  parse_application_id: System.get_env("PARSE_APPLICATION_ID"),
  parse_api_key: System.get_env("PARSE_API_KEY")
