defmodule Narp.Mixfile do
  use Mix.Project

  def project do
    [app: :narp,
     version: "0.0.1",
     elixir: "~> 1.2",
     elixirc_paths: elixirc_paths(Mix.env),
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     deps: deps]
  end

  # Configuration for the OTP application
  #
  # Type `mix help compile.app` for more information
  def application do
    [applications: [:logger]]
  end

  # Specifies which paths to compile
  defp elixirc_paths(:test), do: ["lib", "test/support"]
  defp elixirc_paths(_env), do: ["lib"]

  defp deps do
    []
  end

  defp description do
    """
    Narp is an easy and flexible way to authorize function calls in elixir.
    """
  end

  defp package do
    [maintainers: ["Farhad Taebi", "Matthias Lindhorst"],
     licenses: ["Apache 2.0"],
     links: %{"GitHub" => "https://github.com/faber-lotto/narp"},
     files: ~w(mix.exs README.md test lib)]
  end
end
