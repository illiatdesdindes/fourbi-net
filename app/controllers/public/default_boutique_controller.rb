class Public::DefaultBoutiqueController < Public::DefaultPublicController

  def serie
    @serie = Serie.find(params[:id])
    @page_title = "fourbi.net: #{@serie.nom}"
  end

  def zoom_article
    @article = Article.find(params[:id])
    @image = @article.image.url
    @page_title = "fourbi.net: #{@article.nom}"
    @articles_serie = @article.serie.articles
    @no_layout = true
  end

  def zoom_vue
    @vue = Vue.find(params[:id])
    @article = @vue.article
    @image = @vue.image.url
    @page_title = "fourbi.net: #{@article.nom}"
    @articles_serie = @article.serie.articles
    @no_layout = true
    render :action => :zoom_article
  end

end
