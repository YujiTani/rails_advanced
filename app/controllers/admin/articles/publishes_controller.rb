class Admin::Articles::PublishesController < ApplicationController
  layout 'admin'

  before_action :set_article

  def update
    # 現在時刻Dataオブジェクトを取得
    current_time = Time.current

    @article.published_at = current_time unless @article.published_at?
    # 時差によるバグ防止の為、UTCで比較
    @article.state = if @article.state == 'published' || @article.state == 'publish_wait'
                       current_time.utc.to_f >= @article.published_at.utc.to_f ? :published : :publish_wait
                     end

    if @article.valid?
      # トランザクションを実行
      Article.transaction do
        @article.update!(
          body: @article.build_body(self),
          published_at: @article.published_at,
          state: @article.state
        )
      end

      flash[:notice] = @article.state == 'published' ? '記事を公開しました' : '公開待ちにしました'

      redirect_to edit_admin_article_path(@article.uuid)
    else

      flash.now[:alert] = 'エラーがあります。確認してください。'

      @article.state = @article.state_was if @article.state_changed?
      render 'admin/articles/edit'
    end
  end

  private

  def set_article
    @article = Article.find_by!(uuid: params[:article_uuid])
  end
end
