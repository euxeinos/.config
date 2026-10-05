#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title aerospace config 
# @raycast.mode silent

# Optional parameters:
# @raycast.icon /Users/alexeykotomin/.local/share/img/icons/nix.png
# @raycast.packageName nixos-config
# @raycast.description open ~/nix/modules/shared/config/aerospace.toml via emacsclient

FILE="/Users/alexeykotomin/nix/modules/shared/config/aerospace.toml"

/Users/alexeykotomin/.config/scripts/raycast-scripts/open-scripts/emacsclient -n "$FILE"
