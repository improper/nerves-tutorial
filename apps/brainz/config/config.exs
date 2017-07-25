# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# Customize the firmware. Uncomment all or parts of the following
# to add files to the root filesystem or modify the firmware
# archive.

# config :nerves, :firmware,
#   rootfs_additions: "config/rootfs_additions",
#   fwup_conf: "config/fwup.conf"

# Import target specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
# Uncomment to use target specific configurations

# import_config "#{Mix.Project.config[:target]}.exs"

config :bootloader,
  init: [:nerves_runtime],
  app: :brainz

# Configure these options using environmental variables
# `export BRAINZ_WIFI_SSID=my_accesspoint_name`
# `export BRAINZ_WIFI_PSK=secret`
config :brainz_wifi, :wlan0,
  ssid: System.get_env("BRAINZ_WIFI_SSID"),
  key_mgmt: :"WPA-PSK",
  psk: System.get_env("BRAINZ_WIFI_PSK")

config :web, Web.Endpoint,
  http: [port: 8080],
  url: [host: "localhost", port: 8080],
  secret_key_base: "79608276538942298466299274821",
  root: Path.dirname(__DIR__),
  server: true,
  render_errors: [accepts: ~w(html json)],
  pubsub: [name: Nerves.PubSub],
  code_reloader: false

config :logger,
  backends: [ :console,
              {LoggerMulticastBackend,
                target: {{192,168,213,95}, 514},
                level: :debug}
            ]
