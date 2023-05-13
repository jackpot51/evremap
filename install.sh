#!/usr/bin/env bash

set -ex

cd "$(dirname "$0")"

cargo build --release

sudo cp "${HOSTNAME}.toml" /etc/evremap.toml
sudo cp target/release/evremap /usr/bin/evremap
sudo cp evremap.service /usr/lib/systemd/system/evremap.service

sudo systemctl daemon-reload
sudo systemctl enable evremap.service
sudo systemctl start evremap.service
