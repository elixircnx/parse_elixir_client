# ParseClient
[![Hex.pm
Version](http://img.shields.io/hexpm/v/parse_client.svg)](https://hex.pm/packages/parse_client)

An Elixir client for the parse.com REST API

## Installation

1. Add parse_elixir_client to your `mix.exs` dependencies

  ```elixir
  defp deps do
    [ {:parse_client, "~> 0.2.3"} ]
  end
  ```

2. List `:parse_client` as an application dependency

  ```elixir
  def application do
    [applications: [:logger, :parse_client]]
  end
  ```

3. Run `mix do deps.get, compile`

## Setup

1. Uncomment `import_config "#{Mix.env}.exs"` in `config/config.exs`

2. Create environment files `config/prod.exs` (for production), `config/dev.exs` (for development) and `config/test.exs`

3. Configure parse_client with your parse.com Application ID and API key

  Use system variables (preferred)
  ```elixir    
  # prod.exs

  use Mix.Config

  config :parse_client,
    parse_application_id: System.get_env("PARSE_APPLICATION_ID"),
    parse_api_key: System.get_env("PARSE_API_KEY")
  ```

  Or use them explicitly
  ```elixir    
  # prod.exs

  use Mix.Config

  config :parse_client,
    parse_application_id: "my_Application_ID",
    parse_api_key: "my_REST_API_key"
  ```

## Documentation

http://hexdocs.pm/parse_client

## Goals

- Develop a full featured REST API for parse.com
- Discover, learn and have fun!

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

## Status

This client needs more testing at the production-level,
and so we encourage you to try it out and give us your feedback.

## License

MIT
