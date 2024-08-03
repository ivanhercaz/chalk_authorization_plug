import Config

config :chalk_authorization_plug,
  author: "quarkex"


if (config_env() == :test), do: import_config "#{config_env()}.exs"
