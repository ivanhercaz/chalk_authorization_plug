defmodule ChalkAuthorizationPlug.MixProject do
  use Mix.Project

  def project do
    [
      app: :chalk_authorization_plug,
      version: "0.1.0",
      description: "Chalk authorization system plug for Phoenix Framework",
      elixir: "~> 1.11",
      start_permanent: Mix.env() == :prod,
      package: package(),
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
      {:ex_doc, ">= 0.0.0", only: :dev, runtime: false},
      {:phoenix, "~> 1.5.7"},
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
