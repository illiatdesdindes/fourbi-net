class Public::DefaultPublicController < ApplicationController

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
