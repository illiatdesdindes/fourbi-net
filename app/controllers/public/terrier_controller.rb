class Public::TerrierController < Public::DefaultBoutiqueController

  layout 'public-layout'

  def article
    @article = Article.find(params[:id])
    @page_title = "fourbi.net: #{@article.nom}"
    @custom_javascript = 'var numberArticlesPerPage = 7;'
    @articles_serie = @article.serie.articles
  end

  def boutique
    @page_title = 'fourbi.net: la boutique du terrier'
    @boutique_terrier = Boutique.nom(Boutique::NOM_TERRIER).first
    @articles = trouver_articles(@boutique_terrier, 14)
  end

end
