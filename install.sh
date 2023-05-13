#!/usr/bin/env bash

set -ex

cd "$(dirname "$0")"

cargo build --release

# Copy config file
sudo cp "${HOSTNAME}.toml" /etc/evremap.toml

# Copy and reload service
sudo cp evremap.service /usr/lib/systemd/system/evremap.service
sudo systemctl daemon-reload

# Stop service if running
sudo systemctl stop evremap.service

# Copy new binary
sudo cp target/release/evremap /usr/bin/evremap

# Enable and start service
sudo systemctl enable evremap.service
sudo systemctl start evremap.service
