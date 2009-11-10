class Admin::UtilisateursController < Admin::DefaultAdminController

  layout 'admin-layout'
  before_filter :authorize_base

  def edit
    if request.put?
      @utilisateur = Utilisateur.find(params[:id])
      @utilisateur.attributes = params[:utilisateur]
      set_changes = @utilisateur.changed
      if @utilisateur.save
        flash[:notice] = "Utilisateur \"#{@utilisateur.nom}\" modifié"
        redirect_to :action => :show, :id => @utilisateur
      else
        clean_changes
        flash[:error] = "Utilisateur \"#{@utilisateur.nom}\" non modifié : #{@utilisateur.errors.full_messages[0]}"
      end
    else
      @utilisateur = Utilisateur.find(params[:id])
      @page_title = "Modifier utilisateur \"#{@utilisateur.nom}\""
    end
  end

  def index
    @utilisateurs = Utilisateur.find(:all, :order => 'nom')
    @page_title = 'Liste des utilisateurs'
  end

  def new
    if request.post?
      @utilisateur = Utilisateur.new(params[:utilisateur])
      if @utilisateur.save
        flash[:notice] = "Utilisateur \"#{@utilisateur.nom}\" créé"
        redirect_to :action => :show, :id => @utilisateur
      else
        flash[:error] = "Utilisateur \"#{@utilisateur.nom}\" non modifié : #{@utilisateur.errors.full_messages[0]}"
      end
    else
      @utilisateur = Utilisateur.new
      @page_title = 'Créer un utilisateur'
    end
  end

  def show
    @utilisateur = Utilisateur.find(params[:id])
    @page_title = "Voir utilisateur \"#{@utilisateur.nom}\""
  end

end
