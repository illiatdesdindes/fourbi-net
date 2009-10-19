class Admin::IndexController < Admin::DefaultAdminController

  before_filter :authorize_base

  def index
    @page_title = 'Administration'
  end

end