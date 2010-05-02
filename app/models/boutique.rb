# == Schema Information
#
# Table name: boutiques
#
#  id          :integer         not null, primary key
#  description :text
#  nom         :string(255)     not null
#  numero      :integer         not null
#  created_at  :datetime
#  updated_at  :datetime
#

class Boutique < ActiveRecord::Base

  has_many :utilisateurs

  has_many :series, :order => 'numero ASC'

  validates_presence_of :nom, :message => 'Le nom ne doit pas être vide'
  validates_presence_of  :numero
  validates_uniqueness_of :nom, :message => 'Une boutique avec ce nom existe déjà'
  validates_presence_of :numero
  validates_numericality_of :numero, :allow_nil => false, :only_integer => true, :greater_than_or_equal_to => 0

  validates :nom, :xml => true
  validates :description, :xml => true

  scope :nom, lambda {|nom| {:conditions => {:nom => nom} }}


  NOM_DESORDRE = 'desordre.net'

  NOM_TERRIER = 'le-terrier.net'

end
