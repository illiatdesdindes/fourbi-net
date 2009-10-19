class Admin::DefaultAdminController < ApplicationController

  private

  def authorize_base
    unless session[:id_user] && (@current_user = Utilisateur.find(session[:id_user]))
      session[:original_uri] = request.request_uri
      redirect_to :controller => "admin/sessions", :action => :index
    end
  end


end
