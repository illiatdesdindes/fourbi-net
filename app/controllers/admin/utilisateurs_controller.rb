class Admin::UtilisateursController < Admin::DefaultAdminController

  layout 'admin-layout'
  before_filter :authorize_base

  def edit
    if request.put?
      @utilisateur = Utilisateur.find(params[:id])
      @utilisateur.attributes = params[:utilisateur]
      set_changes = @utilisateur.changed
      if @utilisateur.save
        redirect_to({:action => :show, :id => @utilisateur}, {:notice => "Utilisateur \"#{@utilisateur.nom}\" modifié"})
      else
        clean_changes
        flash[:alert] = "Utilisateur \"#{@utilisateur.nom}\" non modifié : #{@utilisateur.errors.full_messages[0]}"
      end
    else
      @utilisateur = Utilisateur.find(params[:id])
      @page_title = "Modifier utilisateur \"#{@utilisateur.nom}\""
    end
  end

  def index
    @utilisateurs = Utilisateur.order('nom asc')
    @page_title = 'Liste des utilisateurs'
  end

  def new
    if request.post?
      @utilisateur = Utilisateur.new(params[:utilisateur])
      if @utilisateur.save
        redirect_to({:action => :show, :id => @utilisateur}, {:notice => "Utilisateur \"#{@utilisateur.nom}\" créé"})
      else
        flash[:alert] = "Utilisateur \"#{@utilisateur.nom}\" non modifié : #{@utilisateur.errors.full_messages[0]}"
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
