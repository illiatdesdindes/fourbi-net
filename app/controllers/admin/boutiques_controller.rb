class Admin::BoutiquesController < Admin::DefaultAdminController

  layout 'admin-layout'
  before_filter :authorize_base

  def edit
    if request.put?
      @boutique = Boutique.find(params[:id])
      @boutique.attributes = params[:boutique]
      set_changes = @boutique.changed
      if @boutique.save
        redirect_to({:action => :show, :id => @boutique}, {:notice => "Boutique \"#{@boutique.nom}\" modifiée" })
      else
        clean_changes
        flash[:alert] = "Boutique \"#{@boutique.nom}\" non modifiée : #{@boutique.errors.full_messages[0]}"
      end
    else
      @boutique = Boutique.find(params[:id])
      @page_title = "Modifier boutique \"#{@boutique.nom}\""
    end
  end

  def index
    @boutiques = Boutique.order('numero')
    @page_title = 'Liste des boutiques'
  end

  def reorder
    if request.put?
      something_updated = false
      boutique = Boutique.find(params[:id])
      order_string = params[:order]
      order_split = order_string.split('|')
      order_split.each_index do |i|
        id_serie = order_split[i]
        serie = Serie.find(id_serie[id_serie.index('_')...id_serie.size].to_i)
        unless serie.boutique != boutique
          if serie.numero != i
            serie.numero = i
            serie.save!
            something_updated = true
          end
        end
      end
      if something_updated
        flash[:notice] = "Séries mises à jour"
      end
      redirect_to :action => :show, :id => boutique
    else
      @boutique = Boutique.find(params[:id])
      @page_title = "Reclasser les boutiques de #{@boutique.nom}"
      @series = Serie.where('boutique_id = ? and numero != -1', @boutique).order('numero asc')
      @custom_javascript_include = 'jquery.dragsort-0.3.10'
    end
  end

  def show
    @boutique = Boutique.find(params[:id])
    @page_title = "Voir boutique #{@boutique.nom}"
    @series = Serie.where(:boutique_id => @boutique).order('numero asc, nom asc')
  end

end
