# == Schema Information
#
# Table name: clients
#
#  id                            :integer         not null, primary key
#  adresse                       :text            not null
#  code_postal                   :string(255)
#  cyberplus_auth_mode           :string(10)
#  cyberplus_auth_number         :string(6)
#  cyberplus_auth_result         :string(2)
#  cyberplus_card_number         :string(19)
#  cyberplus_extra_result        :string(2)
#  cyberplus_payment_certificate :string(40)
#  cyberplus_result              :string(2)
#  cyberplus_verification_banque :boolean
#  cyberplus_warranty_result     :string(20)
#  date_envoi                    :datetime
#  date_paiement                 :datetime
#  dedicace                      :string(255)
#  email                         :string(255)     not null
#  identifiant                   :string(255)     not null
#  methode_paiement              :string(1)
#  pays                          :string(255)     not null
#  port                          :float           default(0.0), not null
#  prix                          :float           not null
#  status                        :string(255)     not null
#  ville                         :string(255)
#  created_at                    :datetime
#  updated_at                    :datetime
#

class Client < ActiveRecord::Base

  NOUVEAU = 'N'

  REFUSE = 'R'

  PAIEMENT_EN_LIGNE = 'L'

  PAIEMENT_CHEQUE = 'C'

  SUPPRIME = 'S'

  PAYE = 'P'

  ENVOYE = 'E'

  has_many :article_clients, :autosave => true, :dependent => :destroy
  has_many :articles, :through => :article_clients

  validates_presence_of :adresse, :code_postal, :ville, :status, :identifiant, :email
  validates_length_of :pays, :is => 2, :allow_nil => false
  validates_numericality_of :prix, :only_integer => false, :allow_nil => false, :greater_than => 0

  attr_protected :prix,
                 :status,
                 :commande_envoyee,
                 :port,
                 :date_envoi,
                 :date_paiement,
                 :methode_paiement,
                 :cyberplus_auth_mode,
                 :cyberplus_auth_number,
                 :cyberplus_auth_result,
                 :cyberplus_card_number,
                 :cyberplus_extra_result,
                 :cyberplus_payment_certificate,
                 :cyberplus_result,
                 :cyberplus_verification_banque,
                 :cyberplus_warranty_result

  scope :attente_paiement, where('status = ? or status = ?', NOUVEAU, REFUSE).order('id asc').includes([:article_clients => :article])

  scope :attente_envoi, where('status = ? and date_envoi is null', PAYE).order('id asc').includes([:article_clients => :article])

  scope :old, where('(status = ? or status = ?) and extract(epoch from (NOW() - updated_at)) > 1814400', NOUVEAU, REFUSE).order('id asc').includes([:article_clients => :article])

  validate :validation

  def status_lisible
    case status
      when NOUVEAU
        'Nouveau'
      when PAYE
        (methode_paiement == PAIEMENT_EN_LIGNE) ? "Payé en ligne le #{I18n.localize(date_paiement)}" : "Payé par chèque le #{I18n.localize(date_paiement)}"
      when ENVOYE
        'Envoyé'
      when REFUSE
        'Refusé'
      when SUPPRIME
        'Supprimé'
      else
        'Status inconnu'
    end
  end

  before_update :bu

  def bu
    if changes.include? 'status'
      if status == PAYE
        self.date_paiement= DateTime.now
      else
        if status == NOUVEAU
          self.date_paiement= null
        end
        self.methode_paiement= null
      end
    end
  end

  def validation
    if article_clients.empty?
      errors.add_to_base('Aucun article commandé')
    end
    unless EmailVeracity::Address.new(self.email).valid?
      errors.add(:email, 'L\'adresse email est invalide')
    end
    unless [NOUVEAU, PAYE, ENVOYE, SUPPRIME].include? self.status
      errors.add(:status, 'Le statut est invalide')
    end
    if PAYE == self.status && (![PAIEMENT_EN_LIGNE, PAIEMENT_CHEQUE].include? self.methode_paiement)
      errors.add(:methode_paiement, 'La méthode de paiement est invalide')
    end
  end

  def number_shops
    article_clients.collect{ |article_client| article_client.article.serie.boutique_id}.uniq.length
  end

end
