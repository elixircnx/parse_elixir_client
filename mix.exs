defmodule ParseClient.Mixfile do
  use Mix.Project

  @description """
  Elixir client for the parse.com REST API
  """

  def project do
    [
      app: :parse_client,
      version: "0.2.3",
      elixir: "~> 1.0.0",
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
      {:exjsx,   "~> 3.0.0"},
      {:httpoison, "~> 0.5.0"},
      {:earmark, "~> 0.1.10", only: :dev},
      {:ex_doc, "~> 0.6.0", only: :dev}
    ]
  end

  defp package do
   [
     contributors: ["David Whitlock", "Ben Sharman"],
     licenses: ["MIT"],
     links: %{"GitHub" => "https://github.com/elixircnx/parse_elixir_client",
              "Docs" => "http://hexdocs.pm/parse_client"}
   ]
  end
end
