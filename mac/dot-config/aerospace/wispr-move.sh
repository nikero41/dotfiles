#!/bin/bash

current_workspace=$(aerospace list-workspaces --focused)
window_id=$(aerospace list-windows --all --json | jq '.[] | select(.["app-name"] == "Wispr Flow" and .["window-title"] == "Status")["window-id"]')

aerospace move-node-to-workspace --window-id "$window_id" "$current_workspace"
