namespace :article do
  desc '記事のステータスを自動更新する'
  task update_article_state: :environment do
    # TODO: 一旦成功した数をカウントする
    # TODO: 将来的にエラーが発生した数も、カウントする
    success = 0
    # error = 0
    articles = Article.publish_wait.past_published.find_each(&:published!)

    if articles.present?
      articles.each do |article|
        article.update(state: :published)
        success += 1
      end
      puts "result: #{success}/#{articles.length}"
    end

    puts "記事の自動公開タスクが完了しました。更新された記事数: #{success}"
  end

end
