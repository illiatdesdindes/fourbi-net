class Admin::BoutiquesController < Admin::DefaultAdminController

  layout 'admin-layout'
  before_filter :authorize_base

  def index
    @boutiques = Boutique.find(:all, :order => 'numero')
    @page_title = 'Liste des boutiques'
  end

  def reorder
    @boutique = Boutique.find(params[:id])
    @page_title = "Reclasser les boutiques de #{@boutique.nom}"
    @series = Serie.find(:all, :conditions => ['boutique_id = ? and active = true', @boutique], :order => "numero asc")
    @custom_javascript_include = 'dragsort-0.3.min'
  end

  def show
    @boutique = Boutique.find(params[:id])
    @page_title = "Voir boutique #{@boutique.nom}"
    @series = Serie.find(:all, :conditions => ['boutique_id = ?', @boutique], :order => "active desc, numero asc, nom asc")
  end

end
