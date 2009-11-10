class Admin::SeriesController < Admin::DefaultAdminController

  layout 'admin-layout'
  before_filter :authorize_base

  def edit
    if request.put?
      @serie = Serie.find(params[:id])
      etatit_disponible = @serie.disponible?
      @serie.attributes = params[:serie]

      if etatit_disponible && (!@serie.disponible?)
        @serie.numero = -1
      elsif (!etatit_disponible) && @serie.disponible?
        @serie.numero = prochain_numero @serie
      end

      set_changes @serie.changed
      if @serie.save
        flash[:notice] = "Série \"#{@serie.nom}\" modifiée"
        redirect_to :action => :show, :id => @serie
      else
        clean_changes
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
      if @serie.disponible?
        @serie.numero = prochain_numero @serie
      else
        @serie.numero = -1
      end
      if @serie.save
        flash[:notice] = "Série \"#{@serie.nom}\" ajoutée"
        redirect_to :action => :show, :id => @serie
      else
        flash[:error] = "Série \"#{@serie.nom}\" non modifié : #{@serie.errors.full_messages[0]}"
        @page_title = 'Ajouter une série'
        @boutiques = Boutique.find(:all, :order => 'nom')
      end
    else
      @serie = Serie.new
      @serie.boutique = Boutique.find(params[:id])
      @boutiques = Boutique.find(:all, :order => 'numero')
      @page_title = 'Ajouter une série'
    end
  end

  def reorder
    if request.put?
      something_updated = false
      serie = Serie.find(params[:id])
      order_string = params[:order]
      order_split = order_string.split('|')
      order_split.each_index do |i|
        id_article = order_split[i]
        article = Article.find(id_article[id_article.index('_')...id_article.size].to_i)
        unless article.serie != serie
          if article.numero != i
            article.numero = i
            article.save!
            something_updated = true
          end
        end
      end
      if something_updated
        flash[:notice] = "Article mises à jour"
      end
      redirect_to :action => :show, :id => serie
    else
      @serie = Serie.find(params[:id])
      @page_title = "Reclasser les articles de #{@serie.nom}"
      @articles = Article.find(:all, :conditions => ['serie_id = ? and numero != -1', @serie], :order => "numero asc")
      @custom_javascript_include = 'dragsort-0.3.min'
    end
  end

  def show
    @serie = Serie.find(params[:id])
    @articles = Article.find(:all, :conditions => ['serie_id = ?', @serie], :order => "numero asc, nom asc")
    @page_title = "Voir série \"#{@serie.nom}\""
  end

  private

  def prochain_numero serie
    serie_max = Serie.find(:first, :conditions => ['boutique_id = ?', serie.boutique], :order => 'numero desc')
    if serie_max
      serie_max.numero + 1
    else
      0
    end
  end


end
