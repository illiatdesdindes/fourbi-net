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


end
