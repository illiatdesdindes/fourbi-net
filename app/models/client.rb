# == Schema Information
#
# Table name: clients
#
#  id            :integer         not null, primary key
#  adresse       :text            not null
#  code_postal   :string(255)
#  date_envoi    :datetime
#  date_paiement :datetime
#  email         :string(255)     not null
#  identifiant   :string(255)     not null
#  pays          :string(255)     not null
#  prix          :float           not null
#  status        :string(255)     not null
#  ville         :string(255)
#  created_at    :datetime
#  updated_at    :datetime
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

  scope :attente_paiement, :conditions => ['status = ?', NOUVEAU], :order => 'id asc'

  scope :attente_envoi, :conditions => ['(status = ? or status = ?) and date_envoi is null', PAIEMENT_CHEQUE, PAIEMENT_EN_LIGNE], :order => 'id asc'

  validate :validation

  def status_lisible
    case status
      when NOUVEAU
        'Nouveau'
      when PAIEMENT_CHEQUE
        "Payé par chèque le #{I18n.localize(date_paiement)}"
      when PAIEMENT_EN_LIGNE
        "Payé en ligne le #{I18n.localize(date_paiement)}"
      when SUPPRIME
        'Supprimé'
      else
        'Status inconnu'
    end
  end

  def before_update
    if changes.include? 'status'
      if (status == PAIEMENT_CHEQUE) || (status == PAIEMENT_EN_LIGNE)
        self.date_paiement= DateTime.now
      elsif status == NOUVEAU
        self.date_paiement= null
      end
    end
  end

  def validation
    errors.add_to_base('Aucun article commandé') if article_clients.empty?
    unless EmailVeracity::Address.new(email).valid?
      errors.add(:email, 'L\'adresse email est invalide')
    end
  end

end
