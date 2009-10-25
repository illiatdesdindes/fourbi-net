class Admin::UtilisateursController < Admin::DefaultAdminController

  layout 'admin-layout'
  before_filter :authorize_base

  def edit
    if request.put?
      @utilisateur = Utilisateur.find(params[:id])
      @utilisateur.attributes = params[:utilisateur]
      set_changes = @utilisateur.changed
      if @utilisateur.save
        flash[:notice] = "Utilisateur-rice \"#{@utilisateur.nom}\" modifié-e"
        redirect_to :action => :show, :id => @utilisateur
      else
        clean_changes
        flash[:error] = "Utilisateur-trice \"#{@utilisateur.nom}\" non modifié-e : #{@utilisateur.errors.full_messages[0]}"
        @boutiques = Boutique.find(:all, :order => 'nom')
      end
    else
      @utilisateur = Utilisateur.find(params[:id])
      @boutiques = Boutique.find(:all, :order => 'nom')
      @page_title = "Modifier utilisateur-trice \"#{@utilisateur.nom}\""
    end
  end

  def index
    @utilisateurs = Utilisateur.find(:all, :order => 'nom')
    @page_title = 'Liste des utilisateur-rice-s'
  end

  def new
    if request.post?
      @utilisateur = Utilisateur.new(params[:utilisateur])
      if @utilisateur.save
        flash[:notice] = "Utilisateur-rice \"#{@utilisateur.nom}\" créé"
        redirect_to :action => :show, :id => @utilisateur
      else
        flash[:error] = "Utilisateur-trice \"#{@utilisateur.nom}\" non modifié-e : #{@utilisateur.errors.full_messages[0]}"
        @boutiques = Boutique.find(:all, :order => 'nom')
      end
    else
      @utilisateur = Utilisateur.new
      @boutiques = Boutique.find(:all, :order => 'nom')
      @page_title = 'Créer un utilisateur-rice'
    end
  end

  def show
    @utilisateur = Utilisateur.find(params[:id])
    @page_title = "Voir utilisateur-trice \"#{@utilisateur.nom}\""
  end

end
