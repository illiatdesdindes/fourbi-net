class Admin::ArticlesController < Admin::DefaultAdminController

  layout 'admin-layout'
  before_filter :authorize_base

  def add_vue
    article = Article.find(params[:id])
    if request.post?
      @vue = Vue.new(params[:vue])
      @vue.article = article
      if @vue.save
        redirect_to({:action => :show, :id => article}, {:notice => 'Image ajoutée'})
      else
        flash[:alert] = "Image non ajoutée : #{@vue.errors.full_messages[0]}"
        @page_title = 'Ajouter une image'
      end
    else
      @vue = Vue.new
      @vue.article = article
    end
  end

  def delete
    if request.delete?
      article = Article.find(params[:id])
      if article.article_clients.empty?
        article.destroy
        redirect_to({:controller => 'admin/series', :action => :show, :id => article.serie}, {:notice => 'Article supprimé'})
      else
        redirect_to({:action => :show, :id => params[:id]}, {:notice => 'Il existe des commandes pour cet article'})
      end
    else
      redirect_to({:action => :show, :id => params[:id]}, {:notice => 'Mauvaise action'})
    end
  end

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
        redirect_to({:action => :show, :id => @article}, {:notice => "Article \"#{@article.nom}\" modifié"})
      else
        clean_changes
        flash[:alert] = "Article \"#{@article.nom}\" non modifié : #{@article.errors.full_messages[0]}"
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
        redirect_to({:action => :show, :id => @article}, {:notice => "Article \"#{@article.nom}\" ajouté"})
      else
        flash[:alert] = "Article \"#{@article.nom}\" non ajouté : #{@article.errors.full_messages[0]}"
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

  def remove_vue
    if request.delete?
      vue = Vue.find(params[:id]).destroy
      redirect_to({:action => :show, :id => vue.article}, {:notice => 'Image supprimée'})
    else
      redirect_to :controller => "admin/index", :action => :index
    end
  end

  def show
    @article = Article.find(params[:id])
    @page_title = "Voir article \"#{@article.nom}\""
  end

end
