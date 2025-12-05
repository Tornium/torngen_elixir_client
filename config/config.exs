import Config

config :torngen,
  file: "openapi.json",
  out_dir: "lib/",
  generator: :elixir

if config_env() == :test do
  config :torngen_elixir_client,
    api_key: System.get_env("API_KEY") || raise("API_KEY enviornmental variable required")
end
