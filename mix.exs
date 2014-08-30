defmodule ParseClient.Mixfile do
  use Mix.Project

  def project do
    [app: :parse_client,
     version: "0.1.0-dev",
     elixir: "~> 0.15.1",
     name: "PARSE CLIENT",
     source_url: "https://github.com/elixircnx/parse_elixir_client",
     deps: deps]
  end

  # Configuration for the OTP application
  #
  # Type `mix help compile.app` for more information
  def application do
    [applications: [:logger, :httpoison]]
  end

  # Dependencies can be hex.pm packages:
  #
  #   {:mydep, "~> 0.3.0"}
  #
  # Or git/path repositories:
  #
  #   {:mydep, git: "https://github.com/elixir-lang/mydep.git", tag: "0.1"}
  #
  # Type `mix help deps` for more examples and options
  defp deps do
    [
      {:jsex,   "~> 2.0.0"},
      {:httpoison, "~> 0.4.0"},
      {:earmark, "~> 0.1", only: :dev},
      {:ex_doc, "~> 0.5", only: :dev}
    ]
  end
end
