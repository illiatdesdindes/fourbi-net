class Public::DefaultPublicController < ApplicationController

  def find_articles number, boutique
    series = Serie.disponible.boutique(boutique)
    articles = []
    for serie in series
      articles_series = Article.disponible.serie(serie).order('articles.numero asc')
      unless articles_series.empty?
        articles << articles_series.first
        if articles.length == number
          return articles
        end
      end
    end
    articles
  end

  def trouver_articles boutique, max_number
    Article.boutique(boutique.id).premier_serie.serie_disponible.order('series.numero asc, articles.numero asc').limit(max_number)
  end
  
end
