class Admin::DefaultAdminController < ApplicationController

  def set_changes changes
    session[:changes] = changes
  end

  def clean_changes
    session[:changes] = {}
  end

  private

  def authorize_base
    unless session[:id_user] && (@current_user = Utilisateur.find(session[:id_user]))
      session[:original_uri] = request.request_uri
      redirect_to :controller => 'admin/sessions', :action => :index
    else
      @site_admin = @current_user.site_admin?
      @boutiques_layout = Boutique.order('nom asc').includes(:series)
    end
  end

  def authorize_site_admin
    unless @site_admin
      redirect_to({:controller => 'admin/admin'}, {:alert => "Cette fonctionalit&eacute; est r&eacute;serv&eacute;e aux administrateurs du site"})
    end
  end

end
