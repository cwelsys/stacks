################################
# 🦎 KOMODO PERIPHERY CONFIG 🦎 #
################################

## This is the offical "Default" config file for Komodo Periphery.
## It serves as documentation for the meaning of the fields.
## It is located at `https://github.com/moghtech/komodo/blob/main/config/periphery.config.toml`.

## All fields with a "Default" provided are optional. If they are
## left out of the file, the "Default" value will be used.

## If Periphery was installed on the host (systemd install script), this
## file will be located either in `/etc/komodo/periphery.config.toml`,
## or for user installs, `$HOME/.config/komodo/periphery.config.toml`.

## Optional. The port the server runs on.
## Env: PERIPHERY_PORT
## Default: 8120
port = 8120

## The IP address the periphery server will bind to.
## The default will allow it to accept external IPv4 and IPv6 connections.
## Env: PERIPHERY_BIND_IP
## Default: [::]
bind_ip = "[::]"

## The directory periphery will use as the default base for the directories it uses.
## The periphery user must have write access to this directory.
## Env: PERIPHERY_ROOT_DIRECTORY
## Default: /etc/komodo
root_directory = "/home/cwel/.komodo"

## Optional. Override the directory periphery will use to manage repos.
## The periphery user must have write access to this directory.
## Env: PERIPHERY_REPO_DIR
## Default: ${root_directory}/repos
# repo_dir = "/etc/komodo/repos"

## Optional. Override the directory periphery will use to manage stacks.
## The periphery user must have write access to this directory.
## Env: PERIPHERY_STACK_DIR
## Default: ${root_directory}/stacks
# stack_dir = "/etc/komodo/stacks"

## Optional. Override the directory periphery will use to manage builds.
## The periphery user must have write access to this directory.
## Env: PERIPHERY_BUILD_DIR
## Default: ${root_directory}/builds
# build_dir = "/etc/komodo/builds"

## How often Periphery polls the host for system stats,
## like CPU / memory usage.
## Env: PERIPHERY_STATS_POLLING_RATE
## Options: 1-sec, 5-sec, 10-sec, 30-sec, 1-min
## Default: 5-sec
stats_polling_rate = "5-sec"

## Whether stack actions should use `docker-compose ...`
## instead of `docker compose ...`.
## Env: PERIPHERY_LEGACY_COMPOSE_CLI
## Default: false
legacy_compose_cli = false

## Optional. Only include mounts at specific paths in the disk report.
## Env: PERIPHERY_INCLUDE_DISK_MOUNTS
## Default: empty, which won't filter down the disks.
include_disk_mounts = []

## Optional. Don't include these mounts in the disk report.
## Env: PERIPHERY_EXCLUDE_DISK_MOUNTS
## Default: empty, which won't exclude any disks.
exclude_disk_mounts = []

########
# AUTH #
########

## Optional. Limit the ip addresses which can call the periphery api.
## Env: PERIPHERY_ALLOWED_IPS
## Default: empty, which will not block any request by ip.
allowed_ips = []

## Optional. Require callers to provide on of the provided passkeys to access the periphery api.
## Env: PERIPHERY_PASSKEYS or PERIPHERY_PASSKEYS_FILE
## Default: empty, which will not require any passkey to be passed by core.
passkeys = []

############
# Security #
############

## Enable HTTPS server using the given key and cert.
## If true and a key / cert at the given paths are not found,
## self signed keys will be generated using openssl.
## Env: PERIPHERY_SSL_ENABLED
## Default: false (will change to `true` in later release)
ssl_enabled = true

## Path to the ssl key.
## Env: PERIPHERY_SSL_KEY_FILE
## Default: /etc/komodo/ssl/key.pem
ssl_key_file = "/home/cwel/.komodo/ssl/key.pem"

## Path to the ssl cert.
## Env: PERIPHERY_SSL_CERT_FILE
## Default: /etc/komodo/ssl/cert.pem
ssl_cert_file = "/home/cwel/.komodo/ssl/cert.pem"

###########
# LOGGING #
###########

## Specify the logging verbosity
## Options: off, error, warn, info, debug, trace
## Default: info
## Env: PERIPHERY_LOGGING_LEVEL
logging.level = "info"

## Specify the logging format for stdout / stderr.
## Env: PERIPHERY_LOGGING_STDIO
## Options: standard, json, none
## Default: standard
logging.stdio = "standard"

## Specify whether logging is more human readable.
## Note. Single logs will span multiple lines.
## Env: PERIPHERY_LOGGING_PRETTY
## Default: false
logging.pretty = true

## Specify a opentelemetry otlp endpoint to send traces to.
## Example: http://localhost:4317.
## Env: PERIPHERY_LOGGING_OTLP_ENDPOINT
## Optional, no default
logging.otlp_endpoint = ""

## Set the opentelemetry service name attached to the telemetry Periphery will send.
## Env: PERIPHERY_LOGGING_OPENTELEMETRY_SERVICE_NAME
## Default: "Komodo"
logging.opentelemetry_service_name = "Periphery"

#################
# GIT PROVIDERS #
#################

## These will be available to attach to Builds, Repos, Stacks, and Syncs.
## They allow these Resources to clone private repositories.
## They cannot be configured on the environment.

## configure git providers
# [[git_provider]]
# domain = "github.com"
# accounts = [
# 	{ username = "cwelsys", token = "op://Secrets/Git/github token" },
# ]

# [[git_provider]]
# domain = "git.cwel.sh" # use a custom provider, like self-hosted gitea
# accounts = [
# 	{ username = "cwel", token = "op://Secrets/Git/gitea token" },
# ]

# [[git_provider]]
# domain = "localhost:8000" # use a custom provider, like self-hosted gitea
# https = false # use http://localhost:8000 as base-url for clone
# accounts = [
# 	{ username = "mbecker20", token = "access_token_for_account" },
# ]

######################
# REGISTRY PROVIDERS #
######################

## These will be available to attach to Builds and Stacks.
## They allow these Resources to pull private images.
## They cannot be configured on the environment.

## configure docker registries
# [[docker_registry]]
# domain = "docker.io"
# accounts = [
# 	{ username = "mbecker2020", token = "access_token_for_account" }
# ]
# organizations = ["DockerhubOrganization"]

# [[docker_registry]]
# domain = "git.mogh.tech" # use a custom provider, like self-hosted gitea
# accounts = [
# 	{ username = "mbecker20", token = "access_token_for_account" },
# ]
# organizations = ["Mogh"] # These become available in the UI

###########
# SECRETS #
###########

## Provide Core based secrets.
## These will be available to interpolate into your Deployment / Stack environments,
## and will be hidden in the UI and logs.
## These are available to use on any Periphery (Server),
## but you can also limit access more by placing them in a single Periphery's config file instead.
## These cannot be configured in the Komodo Core environment, they must be passed in the file.

#[secrets]
# SECRET_1 = "value_1"
# SECRET_2 = "value_2"
