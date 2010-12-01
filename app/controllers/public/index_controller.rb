class Public::IndexController < Public::DefaultPublicController

  layout 'public-layout'

  def aide
    
  end

  def cgv

  end

  def sommaire
    @page_title = 'fourbi.net, brocante à toutes heures'
    boutique_desordre = Boutique.nom(Boutique::NOM_DESORDRE).first
    @articles_desordre = find_articles 5, boutique_desordre
    boutique_terrier = Boutique.nom(Boutique::NOM_TERRIER).first
    @articles_terrier = find_articles 4, boutique_terrier
  end

end