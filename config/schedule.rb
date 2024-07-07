# このファイルは、Wheneverというgemを使用してcronジョブを設定するためのものです。
# 詳細はこちら: http://github.com/javan/whenever

# Wheneverには、以下の3つのジョブタイプがあらかじめ定義されています：
# command: bashコマンドを実行 (例: command "/usr/bin/my_great_command")
# runner: Railsのメソッドを実行 (例: runner "MyModel.some_method")
# rake: rakeタスクを実行 (例: rake "db:migrate")

# このファイルを使用して、すべてのcronジョブを簡単に定義できます。

# cronについての詳細: http://en.wikipedia.org/wiki/Cron

# Rails.rootを使用するために必要
require File.expand_path(File.dirname(__FILE__) + "/environment")
# cronを実行する環境変数周りの設定
ENV.each { |k, v| env(k, v) }
rails_env = ENV['RAILS_ENV'] || :development
# cronを実行する環境変数をセット
set :environment, rails_env
# 重要な設定オプション：
set :output, "log/cron.log"
# 24時間形式で時間を解釈するようになる
set :chronic_options, hours24: true

# 1分ごとに実行
every 1.minute do
  rake "article:update_publish_wait"
end

# 1時間ごとに実行
# every 1.hour do
#   rake "article:update_publish_wait"
# end

# 毎日午前4時30分に実行
# every 1.day, at: '4:30 am' do
#   rake "db:backup"
# end

# 毎週月曜日の正午に実行
# every :monday, at: '12pm' do
#   command "/usr/bin/some_great_command"
# end

# 4日ごとに実行
# every 4.days do
#   runner "AnotherModel.prune_old_records"
# end

# 詳細はこちら: http://github.com/javan/whenever
