defmodule ChalkAuthorizationPlug.MixProject do
  use Mix.Project

  def project do
    [
      app: :chalk_authorization_plug,
      version: "0.1.2",
      description: "Chalk authorization system plug for Phoenix Framework",
      elixir: "~> 1.11",
      elixirc_paths: elixirc_paths(Mix.env()),
      start_permanent: Mix.env() == :prod,
      package: package(),
      deps: deps(),
      docs: [
        main: "readme",
        extras: ["README.md"]
      ]
    ]
  end

  def application do
    [
      extra_applications: [:logger]
    ]
  end

  defp elixirc_paths(:test), do: ["lib", "test/support"]
  defp elixirc_paths(_), do: ["lib"]

  defp deps do
    [
      {:ex_doc, ">= 0.0.0", only: :dev, runtime: false},
      {:phoenix, ">= 1.5.7"},
      {:jason, "~> 1.0", only: :test},
      {:chalk_authorization, "~> 0.1.0"},
    ]
  end

  defp package do
    [
      maintainers: ["Quarkex"],
      licenses: ["MIT"],
      links: %{"GitHub" => "https://github.com/Quarkex/chalk_authorization_plug"}
    ]
  end
end
