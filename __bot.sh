#!/usr/bin/env bash

set -eu

. /etc/sysconfig/git_poster

REPO="$1"
VERSION="$PRODUCT $2"
LAST_POSTED_COMMIT="$(<$REPO.commit)"
TMPFILE=$TMPDIR/git.log.$$

tweet_make() {
    local subject="$1"
    local jira_task_id="${2:-}"
    echo "$VERSION"
    echo
    echo "$subject"
    if [ -n "${jira_task_id:-}" ]; then
        echo
        echo "$jira_task_id"
    fi
}

mkdir -p $TMPDIR
cd $REPO
git pull origin master
git log $LAST_POSTED_COMMIT.. --grep='.*(.*):.*' --format='%h' > $TMPFILE
while read commit; do
    subject="$(git show $commit --pretty=format:"%s" --no-patch)"
    jira_task_id="$(git show $commit --pretty=format:"%b" --no-patch | tail -1 | egrep "$JIRA_TASK_REGEX")" || true
    tweet="$(tweet_make "$subject" "${jira_task_id:-}")"
    tfctl tweet $BOT_NAME "$tweet"
    echo $tweet
done < $TMPFILE
new_commit="$(head -1 $TMPFILE)"

if [ -n "${new_commit:-}" ]; then
	echo $new_commit > $REPO.commit
fi
rm -f $TMPFILE
