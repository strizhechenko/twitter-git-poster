Bot designed for run in <https://github.com/strizhechenko/twitterbot_farm>.

# Install

``` shell
bot_name="twitter_nickname_without_@"
bot_dir=/opt/twitterbot_farm_bots/$bot_name
mkdir -p $bot_dir
cd $bot_dir
git clone https://github.com/strizhechenko/twitter-git-poster
vim etc/sysconfig/git_poster
cp -av {,/}etc/sysconfig/git_poster
```

# Setup

We need to clone repos which changes we're tracking.

``` shell
mkdir $bot_dir/repos/
git clone git@github.com/strizhechenko/twitter-git-poster $bot_dir/repos/twitter-git-poster
git log # here you should find commit id which will be first to tweet (older will be skipped)
echo $commit > $bot_dir/repos/twitter-git-poster.commit # it's only for first run.
```

# Create bot with tfctl
``` shell
tfctl create <@bot_name> writer <db_id> <token> <secret> '' '' ''
```

# Run

``` shell
$bot_dir/bot.sh 7.4.9 195
```
