class Admin::IndexController < Admin::DefaultAdminController

  layout 'admin-layout'

  before_filter :authorize_base

  def index
    @page_title = 'Administration'
  end

end