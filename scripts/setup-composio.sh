#!/usr/bin/env sh
# Installs the Composio CLI and logs in non-interactively using the
# COMPOSIO_API_KEY environment variable (set it in the cloud environment settings).
set -e
export PATH="$HOME/.local/bin:$PATH"

if ! command -v composio >/dev/null 2>&1; then
  # The installer's "latest release" lookup uses the GitHub API, which may be
  # blocked; resolve the newest stable tag via git instead.
  VERSION=$(git ls-remote --tags https://github.com/ComposioHQ/composio \
    | grep -oE '@composio/cli@[0-9]+\.[0-9]+\.[0-9]+$' \
    | sed 's/@composio\/cli@//' | sort -V | tail -1)
  curl -fsSL https://composio.dev/install -o /tmp/composio-install.sh
  sh /tmp/composio-install.sh "${VERSION}" || true   # plugin setup may fail; CLI still installs
fi

if composio whoami >/dev/null 2>&1; then
  echo "composio: already logged in"
elif [ -n "${COMPOSIO_API_KEY:-}" ]; then
  composio login --user-api-key "$COMPOSIO_API_KEY" --yes --no-skill-install
else
  echo "composio: COMPOSIO_API_KEY is not set — cannot log in" >&2
  exit 1
fi
