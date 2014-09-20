# ParseClient
[![Hex.pm
Version](http://img.shields.io/hexpm/v/parse_client.svg)](https://hex.pm/packages/parse_client)

An Elixir client for the parse.com REST API

## Installation

1. Add parse_elixir_client to your `mix.exs` dependencies

  ```elixir
  defp deps do
    [ {:parse_client, "~> 0.1.1"} ]
  end
  ```

2. List `:parse_client` as an application dependency

  ```elixir
  def application do
    [applications: [:logger, :parse_client]]
  end
  ```

## Setup

1. Uncomment `import_config "#{Mix.env}.exs"` in `config/config.exs`

2. Create environment files `config/prod.exs` (for production), `config/dev.exs` (for development) and `config/test.exs`

3. Define your project config

  ```elixir    
  # prod.exs

  use Mix.Config

  config :my_project_name,
    parse_application_id: "my_REST_API_key",
    parse_api_key: "my_Application_ID"
  ```

## Documentation

Generated docs are hosted on our GitHub page
http://elixircnx.github.io/docs/parse_elixir_client

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

This client is alpha status. It needs more testing at the production-level,
and so we encourage you to try it out and give us your feedback.

## License
MIT
