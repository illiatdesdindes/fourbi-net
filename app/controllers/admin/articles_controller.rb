class Admin::ArticlesController < Admin::DefaultAdminController

  layout 'admin-layout'
  before_filter :authorize_base

  def edit
    if request.put?
      @article = Article.find(params[:id])

      etait_disponible = @article.disponible?
      @article.attributes = params[:article]

      if etait_disponible && ((!@article.disponible?) || (@article.nombre_restant == 0))
        @article.numero = -1
      elsif (!etait_disponible) && @article.disponible? && (@article.nombre_restant != 0)
        @article.numero = Article.prochain_numero @article.serie
      end

      set_changes @article.changed
      if @article.save
        flash[:notice] = "Article \"#{@article.nom}\" modifié"
        redirect_to :action => :show, :id => @article
      else
        clean_changes
        flash[:error] = "Article \"#{@article.nom}\" non modifié : #{@article.errors.full_messages[0]}"
        @series = Serie.boutique(@article.serie.boutique_id)
        @page_title = "Modifier un article \"#{@article.nom}\""
      end
    else
      @article = Article.find(params[:id])
      @series = Serie.boutique(@article.serie.boutique_id)
      @page_title = "Modifier un article \"#{@article.nom}\""
    end
  end

  def new
    if request.post?
      @article = Article.new(params[:article])
      if @article.disponible? && (@article.nombre_restant != 0)
        @article.numero = Article.prochain_numero @article.serie
      else
        @article.numero = -1
      end
      if @article.save
        flash[:notice] = "Article \"#{@article.nom}\" ajouté"
        redirect_to :action => :show, :id => @article
      else
        flash[:error] = "Article \"#{@article.nom}\" non ajouté : #{@article.errors.full_messages[0]}"
        @series = Serie.boutique(@article.serie.boutique_id)
        @page_title = 'Ajouter un article'
      end
    else
      @article = Article.new
      @article.nombre_restant = -1
      @article.serie = Serie.find(params[:id])
      @series = Serie.boutique(@article.serie.boutique_id)
      @page_title = 'Ajouter un article'
    end
  end

  def show
    @article = Article.find(params[:id])
    @page_title = "Voir article \"#{@article.nom}\""
  end

end
