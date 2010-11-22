class Admin::ConfigurationController < Admin::DefaultAdminController

  layout 'admin-layout'

  before_filter :authorize_base

  def index
    if request.post?
      update_meta Meta::EMAIL_DESORDRE
      update_meta Meta::EMAIL_TERRIER
      update_meta Meta::EMAIL_CONTACT
      update_meta Meta::CGV
      update_meta Meta::MAIL_CONFIRMATION_TITRE
      update_meta Meta::MAIL_CONFIRMATION_CONTENU
    end
    @page_title = 'Configuration'
  end

  private

  def update_meta key
    unless params[key].blank?
      Meta.update_value key, params[key]
    end
  end

end