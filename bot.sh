#!/bin/bash

. /etc/sysconfig/git_poster
set -eu

version="$1"

# shellcheck disable=SC2044
for repo in $(find $BOT_HOME/repos -maxdepth 1 -mindepth 1 -type d); do
	$bot_home/__bot.sh "$repo" "$version"
done
