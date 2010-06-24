class Public::DesordreController < Public::DefaultPublicController

  layout 'public-layout'

  def article
    @article = Article.find(params[:id])
    @page_title = "fourbi.net: #{@article.nom}"
    @custom_javascript = 'var numberArticlesPerPage = 7;'
    @articles_serie = @article.serie.articles
  end

  def boutique
    @page_title = 'fourbi.net: la boutique du desordre'
    @boutique_desordre = Boutique.nom(Boutique::NOM_DESORDRE).includes(:series).first
    @articles = trouver_articles(@boutique_desordre.series, 11)
  end

  def serie
    @serie = Serie.find(params[:id])
    @page_title = "fourbi.net: #{@serie.nom}"
  end

end