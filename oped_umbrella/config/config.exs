# This file is responsible for configuring your umbrella
# and **all applications** and their dependencies with the
# help of the Config module.
#
# Note that all applications in your umbrella share the
# same configuration and dependencies, which is why they
# all use the same configuration file. If you want different
# configurations or dependencies per app, it is best to
# move said applications out of the umbrella.
import Config

# Configures the mailer
#
# By default it uses the "Local" adapter which stores the emails
# locally. You can see the emails in your browser, at "/dev/mailbox".
#
# For production it's recommended to configure a different adapter
# at the `config/runtime.exs`.
config :oped, Oped.Mailer, adapter: Swoosh.Adapters.Local

# Swoosh API client is needed for adapters other than SMTP.
config :swoosh, :api_client, false

config :oped_web,
  generators: [context_app: :oped]

# Configures the endpoint
config :oped_web, OpedWeb.Endpoint,
  url: [host: "localhost"],
  render_errors: [view: OpedWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: Oped.PubSub,
  live_view: [signing_salt: "lULfuvdO"],
  server: false

# Configures the endpoint
config :blog, BlogWeb.Endpoint,
  url: [host: "localhost"],
  render_errors: [view: BlogWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: Blog.PubSub,
  live_view: [signing_salt: "CojISTwC"],
  server: false

# Configure esbuild (the version is required)
config :esbuild,
  version: "0.14.29",
  default: [
    args:
      ~w(js/app.js --bundle --target=es2017 --outdir=../priv/static/assets --external:/fonts/* --external:/images/*),
    cd: Path.expand("../apps/oped_web/assets", __DIR__),
    env: %{"NODE_PATH" => Path.expand("../deps", __DIR__)}
  ]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

config :master_proxy,
  http: [port: 4000],
  # Missing key/keyfile error
  # See https://elixirforum.com/t/multiple-https-sites-on-gigalixir-using-master-proxy/33608 for more details
  # https: [port: 4001],
  backends: [
    %{
      domain: "blog.lvh.me",
      phoenix_endpoint: BlogWeb.Endpoint
    },
    %{
      domain: "lvh.me",
      phoenix_endpoint: OpedWeb.Endpoint
    },
    %{
      verb: ~r/get/i,
      path: ~r{^/master-proxy-plug-test$},
      plug: MasterProxy.Plug.Test,
      opts: [1, 2, 3]
    }
  ]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{config_env()}.exs"
