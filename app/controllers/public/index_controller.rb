class Public::IndexController < Public::DefaultPublicController

  layout 'public-layout'

  def article_desordre
    @article = Article.find(params[:id])
    @page_title = "fourbi.net: #{@article.nom}"
    @custom_javascript = 'var numberArticlesPerPage = 7;'
  end

  def article_terrier

  end

  def boutique_desordre
    @page_title = 'fourbi.net: la boutique du desordre'
    boutique
    @articles = trouver_articles(@boutique_desordre.series, 13)
  end

  def boutique_terrier
    @page_title = 'fourbi.net: la boutique du terrier'
    boutique
    @articles = trouver_articles(@boutique_terrier.series, 15)
  end

  def serie_desordre

  end

  def serie_terrier

  end

  def sommaire
    @page_title = 'fourbi.net, brocante à toutes heures'
    boutique_desordre = Boutique.nom(Boutique::NOM_DESORDRE).first
    @articles_desordre = find_articles 3, boutique_desordre
    boutique_terrier = Boutique.nom(Boutique::NOM_TERRIER).first
    @articles_terrier = find_articles 4, boutique_terrier
  end

  private

  def find_articles number, boutique
    series = Serie.disponible.boutique(boutique)
    articles = []
    for serie in series
      articles_series = Article.disponible.serie(serie).order('random()')
      unless articles_series.empty?
        articles << articles_series.first
        if articles.length == number
          return articles
        end
      end
    end
    articles
  end

  def boutique
    @boutique_desordre = Boutique.nom(Boutique::NOM_DESORDRE).includes(:series).first
    @boutique_terrier = Boutique.nom(Boutique::NOM_DESORDRE).includes(:series).first
  end

  def trouver_articles series, max_number
    articles = []
    for serie in series
      if article = Article.disponible.serie(serie).order('random()').first
        articles << article
        if articles.length == max_number
          return articles
        end
      end
    end
    articles
  end

end