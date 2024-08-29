class Admin::Site::AttachmentsController < Admin::SitesController
  before_action :set_site

  def destroy
    Rails.logger.debug { "Attachment ID: #{params[:id]}" }

    authorize(current_site) # current_siteはSite.firstで対応できるが、今後の拡張を考慮して権限管理する
    ActiveStorage::Attachment.find(params[:id]).purge
    @site.save
    redirect_to edit_admin_site_path
  end

  private

  def set_site
    @site = Site.find(current_site.id)
  end
end
