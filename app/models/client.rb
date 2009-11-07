# == Schema Information
#
# Table name: clients
#
#  id               :integer         not null, primary key
#  adresse          :text            not null
#  code_postal      :string(255)
#  commande_envoyee :boolean         not null
#  email            :string(255)     not null
#  identifiant      :string(255)     not null
#  pays             :string(255)     not null
#  prix             :float           not null
#  status           :string(255)     not null
#  ville            :string(255)
#  created_at       :datetime
#  updated_at       :datetime
#

class Client < ActiveRecord::Base

  NOUVEAU = 'N'

  PAIEMENT_EN_LIGNE = 'L'

  PAIEMENT_CHEQUE = 'C'

  SUPPRIME = 'S'

  has_many :article_clients, :autosave => true
  has_many :articles, :through => :article_clients

  validates_presence_of :adresse, :code_postal, :ville, :status, :identifiant, :email
  validates_length_of :pays, :is => 2, :allow_nil => false
  validates_numericality_of :prix, :only_integer => false, :allow_nil => false, :greater_than => 0

  attr_protected :prix, :status, :commande_envoyee

  def status_lisible
    case status
      when NOUVEAU
        'Nouveau'
      when PAIEMENT_CHEQUE
        'Payé par chèque'
      when PAIEMENT_EN_LIGNE
        'Payé en ligne'
      when SUPPRIME
        'Supprimé'
      else
        'Status inconnu'
    end
  end

  named_scope :attente_paiement, :conditions => ['status = ?', NOUVEAU], :order => 'id asc'

  named_scope :attente_envoi, :conditions => ['(status = ? or status = ?) and commande_envoyee = false', PAIEMENT_CHEQUE, PAIEMENT_EN_LIGNE], :order => 'id asc'

end
