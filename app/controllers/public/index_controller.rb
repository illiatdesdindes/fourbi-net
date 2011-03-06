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
    @custom_header = '<meta name="description" content="Le fourbi est un site internet hyper marchand, dans lequel Philippe De Jonckheere et L.L. de Mars, avec l\'aide de Julien Kirch, tentent honteusement de vous refiler leur came, essentiellement des photographies de l\'un et une foison d\'autres oeuvres de l\'autre, en tout cas cela permet à l\'un de tenir son matériel à jour et à l\'autre de se racheter de la peinture quand il y n\'en a plus dans les tubes, donc c\'est important"/><meta name="keywords" content="L.L. de Mars, Julien Kirch, le Terrier, Désordre, Archiloque, photographie, bandes dessinées, littérature, peinture, gravure, tirages, vente en ligne, boutique, Apnées, Harvest, Mail Pornography, pornographie, Surexposé, Président des otaries de droite, Small brother, Le sourire extatique des suppliciées, Rayogrammes, L\'autoportrait en carrés, Hommage à Henri Cartier-Bresson, Campagne, Trajets, Singletons, mAdeleiNNE, Faux raccords, A l\'Est, Michel Vachey, la parole vaine, enculer, oolong, MMI, Stéphane Batsal, Jean-Christophe Pagès, Fusées, Quelques prières d\'urgence à réciter en cas de fin des temps, Henri le lapin à grosses couilles, Le Glatin, Docilités, Microtonies, 5X seul, M, Maldoror, chutes, Perpendicule, Cavazzoni, livres de prières, nombreux passages, lourde presse, Prends-moi dans mon cul plein de merde, dessins politiques, Les bienfaits du colonialisme, CQFD, plan B, autisme, comportementalistes, Aurélien Fordada, Pierre Masseau, Philippe De Jonckheere"/>'
  end

end