namespace :article do
  desc '記事のステータスを自動更新する'
  task update_publish_wait: :environment do
    # TODO: 一旦成功した数をカウントする
    # TODO: 将来的にエラーが発生した数も、カウントする
    success = 0
    # error = 0
    articles = Article.publish_wait

    articles.each do |article|
      if article.state == 'publish_wait' && Time.current.utc.to_f < article.published_at.utc.to_f
        article.update(state: :published)
        success += 1
      end
    end

    p "result: #{success}/#{articles.count}"
  end
end
