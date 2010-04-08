class Public::IndexController < Public::DefaultPublicController

  layout 'public-layout'

  def article_desordre

  end

  def article_terrier

  end

  def boutique_desordre
    @page_title = 'fourbi.net: la boutique du desordre'
    @boutique = Boutique.where(:nom => Boutique::NOM_DESORDRE).includes(:series).first
    boutique
  end

  def boutique_terrier
    @page_title = 'fourbi.net: la boutique du terrier'
    @boutique = Boutique.where(:nom => Boutique::NOM_TERRIER).includes(:series).first
    boutique
  end

  def sommaire
    @page_title = 'fourbi.net, brocante à toutes heures'
    boutique_desordre = Boutique.where(:nom => Boutique::NOM_DESORDRE).first
    @articles_desordre = find_articles 3, boutique_desordre
    boutique_terrier = Boutique.where(:nom => Boutique::NOM_TERRIER).first
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
    @series = Serie.boutique(@boutique).disponible
    if params[:id]
      @serie = Serie.find(params[:id])
    else
      @serie = @series[0]
    end
  end

end