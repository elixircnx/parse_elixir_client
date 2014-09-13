ParseClient
===================

An Elixir client for the parse.com REST API

## Setup

Set environment variables using your parse.com project settings.

Ubuntu example in *./bash_profile* or *./bashrc*
```    
PARSE_REST_API_KEY=my_REST_API_key
PARSE_APPLICATION_ID=my_Application_ID
```

## Installation

1. Add parse_elixir_client to your `mix.exs` dependencies

  ```elixir
  defp deps do
    [ {:parse_client, "~> 0.1.1-dev"} ]
  end
  ```

2. List `:parse_client` as an application dependency

  ```elixir
  def application do
    [applications: [:logger, :parse_client]]
  end
  ```

## Goals

- Develop a full featured REST API for parse.com
- Distribute as a Hex package
- Discover, learn and have fun!

## Documentation

Generated docs are hosted on our GitHub page
http://elixircnx.github.io/docs/parse_elixir_client

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

## Warning!

This client is not ready to be used in production yet.

## License
MIT
