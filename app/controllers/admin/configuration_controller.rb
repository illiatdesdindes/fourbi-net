class Admin::ConfigurationController < Admin::DefaultAdminController

  layout 'admin-layout'

  before_filter :authorize_base

  def index
    if request.post?
      update_meta Meta::EMAIL_DESORDRE
      update_meta Meta::EMAIL_TERRIER
      update_meta Meta::CGV
      update_meta Meta::MAIL_CONFIRMATION_TITRE
      update_meta Meta::MAIL_CONFIRMATION_CONTENU
      unless params[Meta::CYBERPLUS_SITE_ID].blank?
        if (params[Meta::CYBERPLUS_SITE_ID].size != 8)
          flash[:error] = 'La valeur du site_id ne fait pas 8 caractères de long'
        else
          update_meta Meta::CYBERPLUS_SITE_ID
        end
      end
      unless params[Meta::CYBERPLUS_CERTIFICAT].blank?
        update_meta Meta::CYBERPLUS_CERTIFICAT
      end
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