#!/bin/bash

set -eu
version="$1"
bot_home=/opt/twitterbot_farm_bots/carbon_reductor/
# shellcheck disable=SC2044
for repo in $(find $bot_home/repos -maxdepth 1 -mindepth 1 -type d); do
	$bot_home/__bot.sh "$repo" "$version"
done
