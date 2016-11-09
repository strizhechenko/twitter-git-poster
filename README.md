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

# Create bot with tfctl
``` shell
tfctl create <@bot_name> writer <db_id> <token> <secret> '' '' ''
```

# Run

``` shell
$bot_dir/bot.sh 7.4.9 195
```
