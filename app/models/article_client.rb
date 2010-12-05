# == Schema Information
#
# Table name: article_clients
#
#  id            :integer         not null, primary key
#  article_id    :integer         not null
#  client_id     :integer         not null
#  prix_unitaire :float           not null
#  quantite      :integer         not null
#

class ArticleClient < ActiveRecord::Base

  validates_presence_of :article, :client, :quantite, :prix_unitaire
  validates_numericality_of :prix_unitaire, :only_integer => false, :allow_nil => false, :greater_than => 0
  validates_numericality_of :quantite, :only_integer => true, :allow_nil => false, :greater_than => 0

  belongs_to :article
  belongs_to :client

  before_validation :on_create => :set_price


  def set_price
    if article
      self.prix_unitaire = article.prix
    end
  end

  before_create :bc

  def bc
    update_article quantite
  end

  before_destroy :bd

  def bd
    update_article -quantite
  end

  before_update :bu

  def bu
    if changes.include? 'quantite'
      c = changes['quantite']
      update_article(c[1] - c[0])
    end
  end

  def update_article delta
    if article.nombre_restant != -1
      if (delta > 0) && (article.nombre_restant < delta)
        client.errors.add('prix', "Il manque #{delta - article.nombre_restant} exemplaire(s) de #{article.nom} en stock pour pouvoir valider votre commande, merci d'en supprimer")
        false
      else
        article.nombre_restant -= delta
        article.save!
      end
    end
  end


end
