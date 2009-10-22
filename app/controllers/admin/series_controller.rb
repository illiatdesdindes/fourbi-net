class Admin::SeriesController < Admin::DefaultAdminController

  layout 'admin-layout'
  before_filter :authorize_base

  def edit
    if request.put?
      @serie = Serie.find(params[:id])
      was_active = @serie.active?
      @serie.attributes = params[:serie]

      if was_active && (!@serie.active?)
        @serie.numero = -1
      elsif (!was_active) && @serie.active?
        serie_max = Serie.find(:first, :conditions => ["boutique_id = ?", @serie.boutique_id], :order => 'numero desc')
        if serie_max
          @serie.numero = serie_max.numero + 1
        else
          @serie.numero = 0
        end
      end

      @changes = @serie.changed
      if @serie.save
        flash[:notice] = "Série \"#{@serie.nom}\" modifiée"
        redirect_to :action => :show, :id => @serie.id
      else
        flash[:error] = "Série \"#{@serie.nom}\" non modifié-e : #{@serie.errors.full_messages[0]}"
        @boutiques = Boutique.find(:all, :order => 'nom')
      end
    else
      @serie = Serie.find(params[:id])
      @boutiques = Boutique.find(:all, :order => 'nom')
      @page_title = "Modifier série \"#{@serie.nom}\""
    end

  end

  def new
    if request.post?
      @serie = Serie.new(params[:serie])
      if @serie.active?
        serie_max = Serie.find(:first, :conditions => ["boutique_id = ?", @serie.boutique], :order => 'numero desc')
        if serie_max
          @serie.numero = serie_max.numero + 1
        else
          @serie.numero = 0
        end
      else
        @serie.numero = -1
      end
      if @serie.save
        flash[:notice] = "Série \"#{@serie.nom}\" créée"
        redirect_to :action => :show, :id => @serie.id
      else
        flash[:error] = "Série \"#{@serie.nom}\" non modifié-e : #{@serie.errors.full_messages[0]}"
        @boutiques = Boutique.find(:all, :order => 'nom')
      end
    else
      @serie = Serie.new
      @serie.boutique = Boutique.find(params[:id])
      @boutiques = Boutique.find(:all, :order => 'numero')
      @page_title = 'Créer une série'
    end
  end

  def show
    @serie = Serie.find(params[:id])
    @page_title = "Voir série \"#{@serie.nom}\""

  end


end
