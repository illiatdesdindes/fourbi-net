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

  def before_validation_on_create
    if article
      self.prix_unitaire = article.prix
    end
  end

  def before_create
    update_article quantite
  end

  def before_destroy
    update_article -quantite
  end

  def before_update
    if changes.include? 'quantite'
      c = changes['quantite']
      update_article(c[1] - c[0])
    end
  end

  def update_article delta
    if delta < 0 && article.nombre_restant == 0
      raise 'Plus d\'exemplaire de l\'article restant, impossible de le réserver'
    elsif article.nombre_restant != -1
      article.nombre_restant += article.nombre_restant
      article.save!
    end
  end


end
