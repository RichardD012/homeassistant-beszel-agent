#!/usr/bin/with-contenv bashio

VERSION=$(cat VERSION)
BESZEL_AGENT_VERSION=$(cat BESZEL_AGENT_VERSION)
PUBLIC_KEY="$(bashio::config 'public_key')"
TOKEN="$(bashio::config 'token')"
HUB_URL="$(bashio::config 'hub_url')"

# add date to default bashio log timestamp
declare __BASHIO_LOG_TIMESTAMP="%Y-%m-%d %T"

bashio::log.info "Beszel-Agent Home Assistant Add-On $VERSION"
bashio::log.info "Beszel-Agent $BESZEL_AGENT_VERSION"

# Check if TOKEN and HUB_URL are provided for new hub-based mode
if [ -n "$TOKEN" ] && [ -n "$HUB_URL" ]; then
    bashio::log.info "Starting with hub-based configuration"
    PORT=45876 KEY="$PUBLIC_KEY" TOKEN="$TOKEN" HUB_URL="$HUB_URL" ./beszel-agent
else
    bashio::log.info "Starting with legacy key-based configuration"
    PORT=45876 KEY="$PUBLIC_KEY" ./beszel-agent
fi
