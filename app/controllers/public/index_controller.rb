class Public::IndexController < Public::DefaultPublicController

  layout 'public-layout'

  def article_desordre

  end

  def article_terrier

  end

  def boutique_desordre

  end

  def boutique_terrier
    
  end

  def sommaire
    @page_title = ''
    boutique_desordre = Boutique.where(:nom => Boutique::NOM_DESORDRE).first
    @articles_desordre = find_articles 3, boutique_desordre
    boutique_terrier = Boutique.where(:nom => Boutique::NOM_TERRIER).first
    @articles_terrier = find_articles 4, boutique_terrier
  end

  private

  def find_articles number, boutique
    series = Serie.where(:boutique_id => boutique).order('id desc')
    articles = []
    for serie in series
      articles_series = Article.where(:serie_id => serie.id).order('random()')
      unless articles_series.empty?
        articles << articles_series.first
        if articles.length == number
          return articles
        end
      end
    end
    articles
  end
end