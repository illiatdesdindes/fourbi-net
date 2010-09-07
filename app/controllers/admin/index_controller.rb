class Admin::IndexController < Admin::DefaultAdminController

  layout 'admin-layout'

  before_filter :authorize_base

  def index
    ActiveRecord::SessionStore::Session.delete_all(["updated_at < ?", 1.hours.ago])
    @page_title = 'Administration'
  end

end