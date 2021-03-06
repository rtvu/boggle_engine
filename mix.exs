defmodule BoggleEngine.MixProject do
  use Mix.Project

  def project do
    [
      app: :boggle_engine,
      version: "0.1.0-dev",
      elixir: "~> 1.9",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  def application do
    [
      extra_applications: [:logger]
    ]
  end

  defp deps do
    [
      {:ex_doc, "~> 0.21", only: :dev, runtime: false},
      {:lexicon, "~> 0.2.0"},
      {:erlang_algorithms, github: "aggelgian/erlang-algorithms", app: false}
    ]
  end
end
