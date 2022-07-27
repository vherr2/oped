import Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :oped_web, OpedWeb.Endpoint,
  http: [ip: {127, 0, 0, 1}, port: 4002],
  secret_key_base: "PEZlJMYrOh1ju9ri7OFCAzanFMzPDPEv5EvbJ3DpONRHk0B+B4JPvygceCNeI5m7",
  server: false

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :blog, BlogWeb.Endpoint,
  http: [ip: {127, 0, 0, 1}, port: 4002],
  secret_key_base: "tWkYuFs/vPdK9d5ZqqNd/gaq+kNlwF5Grg/q0axS34x9lKn72SHh6MQvfCFX5cDt",
  server: false

# Print only warnings and errors during test
config :logger, level: :warn

# In test we don't send emails.
config :oped, Oped.Mailer, adapter: Swoosh.Adapters.Test

# Initialize plugs at runtime for faster test compilation
config :phoenix, :plug_init_mode, :runtime
