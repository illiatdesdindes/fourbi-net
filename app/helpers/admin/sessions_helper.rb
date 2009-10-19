module Admin::SessionsHelper

  def session_path
    url_for :controller => 'admin/sessions', :action => :create
  end

end