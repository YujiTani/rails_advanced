class Admin::Articles::PublishesController < ApplicationController
  layout 'admin'

  before_action :set_article

  def update
    @article.published_at = Time.current unless @article.published_at?
    @article.state = @article.publishable? ? :published : :publish_wait

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
