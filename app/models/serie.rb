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
  has_many :articles, :order => 'numero ASC'

  validates_presence_of :nom, :numero, :boutique_id
  validates_numericality_of :numero, :allow_nil => false, :only_integer => true, :greater_than_or_equal_to => -1

  attr_writer :disponible

  scope :boutique, lambda {|boutique| {:conditions => {:boutique_id => boutique}, :order => 'numero desc'} }

  scope :disponible, :conditions => ['numero != ?', -1], :order => 'numero desc'

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
