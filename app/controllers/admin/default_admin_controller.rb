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
      redirect_to :controller => "admin/sessions", :action => :index
    else
      @site_admin = @current_user.site_admin?
      if @current_user.boutique
        @current_series = Serie.find(:all, :conditions => ['boutique_id = ? and active= true', @current_user.boutique], :order => 'numero asc')
      else
        @current_series = []
      end
    end
  end

  def authorize_site_admin
    unless @site_admin
      flash[:error] = "Cette fonctionalit&eacute; est r&eacute;serv&eacute;e aux administrateurs du site"
      redirect_to(:controller => "admin/admin")
    end
  end

end
