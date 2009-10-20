class Admin::BoutiquesController < Admin::DefaultAdminController

  layout 'admin-layout'
  before_filter :authorize_base

  def index
    @boutiques = Boutique.find(:all, :order => 'numero')
    @page_title = 'Liste des boutiques'
  end


  def show
    @boutique = Boutique.find(params[:id])
    @page_title = "Voir boutique \"#{@boutique.nom}\""
  end

end
