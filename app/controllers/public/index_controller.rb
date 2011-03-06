class Public::IndexController < Public::DefaultPublicController

  layout 'public-layout'

  def aide

  end

  def cgv

  end

  def nouveautes
    @nouveautes = Article.nouveaute(12).includes(:serie => :boutique)
    @page_title = 'fourbi.net: les nouveautés'
  end

  def sommaire
    @page_title = 'fourbi.net, brocante à toutes heures'
    boutique_desordre = Boutique.nom(Boutique::NOM_DESORDRE).first
    @articles_desordre = find_articles 5, boutique_desordre
    boutique_terrier = Boutique.nom(Boutique::NOM_TERRIER).first
    @articles_terrier = find_articles 4, boutique_terrier
    @nouveautes = Article.nouveaute(3).includes(:serie => :boutique)
  end

end