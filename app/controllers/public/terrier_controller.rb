class Public::TerrierController < Public::DefaultPublicController

  layout 'public-layout'

  def article
    @article = Article.find(params[:id])
    @page_title = "fourbi.net: #{@article.nom}"
    @custom_javascript = 'var numberArticlesPerPage = 7;'
    @articles_serie = @article.serie.articles
  end

  def boutique
    @page_title = 'fourbi.net: la boutique du terrier'
    @boutique_terrier = Boutique.nom(Boutique::NOM_TERRIER).includes(:series).first
    @articles = trouver_articles(@boutique_terrier.series, 14)
  end

  def serie
    @serie = Serie.find(params[:id])
    @page_title = "fourbi.net: #{@serie.nom}"
  end

end
