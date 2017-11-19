use Mix.Config

config :ring_my_bell_ex, RingMyBellExWeb.Endpoint,
  load_from_system_env: true,
  url: [host: "ring-my-bell-ex.herokuapp.com", port: 443],
  cache_static_manifest: "priv/static/cache_manifest.json",
  secret_key_base: Map.fetch!(System.get_env(), "SECRET_KEY_BASE")

# Do not print debug messages in production
config :logger, level: :info
