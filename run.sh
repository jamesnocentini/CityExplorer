#!/usr/bin/env bash
sleep 20
/usr/local/bin/sync_gateway ./sync-gateway-config.json &
babel-node server.js