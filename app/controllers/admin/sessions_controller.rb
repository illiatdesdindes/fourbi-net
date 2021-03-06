class Admin::SessionsController < Admin::DefaultAdminController

  def init
    if request.post?
      if Utilisateur.all.empty?
        user = Utilisateur.new
        user.login = params[:login]
        user.nom = params[:nom]
        user.email = params[:email]
        user.mot_de_passe = params[:mot_de_passe]
        user.site_admin = true
        if !user.save
          flash[:alert] = "Utilisateur non cr&eacute;&eacute; : #{user.errors.full_messages[0]}"
        else
          render :action => :index
        end
      else
        redirect_to :action => :index
      end
    end
  end

  def index
    session[:id_user] = nil
    if Utilisateur.all.empty?
      redirect_to :action => :init
    elsif request.post?
      user = Utilisateur.authenticate(params[:login], params[:mot_de_passe])
      if user
        cleanup_sessions
        cleanup_clients
        session[:id_user] = user.id
        uri = session[:original_uri]
        session[:original_uri] = nil
        redirect_to(uri || {:controller => 'admin/index'})
      else
        flash[:alert] = 'Login / Mot de passe invalide'
      end
    end
  end

  def logout
    session[:id_user] = nil
    flash[:notice] = 'Déconnecté'
    redirect_to :action => :index
  end

  private

  def cleanup_sessions
    ActiveRecord::Base.connection.execute('DELETE FROM sessions WHERE extract(epoch from (NOW() - updated_at)) > 3600')
  end

  def cleanup_clients
    Client.old.destroy_all
  end


end
