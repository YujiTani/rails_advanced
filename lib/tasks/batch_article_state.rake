namespace :batch_article_state do
  # TODO: 1時間ごとに自動でtaskが走るようにする
  desc "1時間ごとに公開できる記事がないかチェックする"
  task check_publish_wait_articles: :environment do
    articles = Article.publish_wait
    articles.each do |article|
      article.update(state: :published) if Time.current.utc.to_f < article.published_at.utc.to_f
    end
  end
end
