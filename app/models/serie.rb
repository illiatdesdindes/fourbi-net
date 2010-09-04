# == Schema Information
#
# Table name: series
#
#  id          :integer         not null, primary key
#  boutique_id :integer         not null
#  description :text
#  nom         :string(255)     not null
#  numero      :integer         not null
#  created_at  :datetime
#  updated_at  :datetime
#

require 'erb'

class Serie < ActiveRecord::Base

  include ERB::Util

  belongs_to :boutique

  has_many :articles

  validates_presence_of :nom, :numero, :boutique_id
  validates_numericality_of :numero, :allow_nil => false, :only_integer => true, :greater_than_or_equal_to => -1

  validates :nom, :xml => true
  validates :description, :xml => true

  attr_writer :disponible

  scope :nom_boutique, lambda {|nom_boutique| where('boutiques.nom' => nom_boutique).order('series.numero desc').include(:boutique) }

  scope :boutique, lambda {|boutique| where(:boutique_id => boutique).order('series.numero desc') }

  scope :disponible, where('series.numero != ?', -1).order('series.numero desc')

  def nom_disponible
    if numero != -1
      nom
    else
      "#{nom} *"
    end
  end

  def disponible?
    if @disponible.nil?
      numero != -1
    else
      @disponible != '0'
    end
  end

end
