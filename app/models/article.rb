# == Schema Information
#
# Table name: articles
#
#  id             :integer         not null, primary key
#  description    :text
#  nom            :string(255)     not null
#  nombre_restant :integer         not null
#  numero         :integer         not null
#  prix           :float           not null
#  serie_id       :integer         not null
#  created_at     :datetime
#  updated_at     :datetime
#

class Article < ActiveRecord::Base
  belongs_to :serie

  attr_writer :disponible

  validates_presence_of :nom, :serie_id, :prix, :nombre_restant, :numero
  validates_uniqueness_of :nom
  validates_numericality_of :prix, :allow_nil => true, :greater_than_or_equal_to => 0, :message => 'doit ê;tre supérieur ou égal à 0'
  validates_numericality_of :nombre_restant, :only_integer => true, :allow_nil => false, :greater_than_or_equal_to => -1
  validates_numericality_of :numero, :allow_nil => false, :only_integer => true, :greater_than_or_equal_to => -1

  def disponible?
    if @disponible.nil?
      numero != -1
    else
      @disponible != '0'
    end
  end


end
