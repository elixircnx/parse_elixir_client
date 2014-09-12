defmodule ParseClient.Mixfile do
  use Mix.Project

  @description """
    Elixir client for the parse.com REST API
  """

  def project do
    [
      app: :parse_client,
      version: "0.1.1-dev",
      elixir: "~> 1.0.0-rc1",
      name: "Parse Client",
      description: @description,
      package: package,
      source_url: "https://github.com/elixircnx/parse_elixir_client",
      deps: deps
    ]
  end

  def application do
    [applications: [:logger, :httpoison]]
  end

  defp deps do
    [
      {:jsex,   "~> 2.0.0"},
      {:httpoison, "~> 0.4.0"},
      {:earmark, "~> 0.1", only: :dev},
      {:ex_doc, "~> 0.5", only: :dev}
    ]
  end

  defp package do
   [
     contributors: ["David Whitlock", "Ben Sharman"],
     licenses: ["MIT"],
     links: [github: "https://github.com/elixircnx/parse_elixir_client",
             docs: "http://elixircnx.github.io/docs/parse_elixir_client"]
   ]
  end
end
