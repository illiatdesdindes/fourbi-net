class Admin::ConfigurationController < Admin::DefaultAdminController

  layout 'admin-layout'

  before_filter :authorize_base

  def index
    if request.post?
      Meta.update_value Meta::EMAIL_DESORDRE, params[Meta::EMAIL_DESORDRE]
      Meta.update_value Meta::EMAIL_TERRIER, params[Meta::EMAIL_TERRIER]
      Meta.update_value Meta::CGV, params[Meta::CGV]
    end
    @page_title = 'Configuration'
  end

end