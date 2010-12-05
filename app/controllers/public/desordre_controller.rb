class Public::DesordreController < Public::DefaultBoutiqueController

  layout 'public-layout'

  def article
    @panier = session[:panier] || []
    @article = Article.find(params[:id])
    @page_title = "fourbi.net: #{@article.nom}"
    @custom_javascript = 'var numberArticlesPerPage = 7;'
    @articles_serie = @article.serie.articles
  end

  def boutique
    @page_title = 'fourbi.net: la boutique du desordre'
    @boutique_desordre = Boutique.nom(Boutique::NOM_DESORDRE).first
    @articles = trouver_articles(@boutique_desordre, 11)
  end

end