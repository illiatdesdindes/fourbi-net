# == Schema Information
#
# Table name: boutiques
#
#  id         :integer         not null, primary key
#  nom        :string(255)     not null
#  numero     :integer         not null
#  created_at :datetime
#  updated_at :datetime
#

class Boutique < ActiveRecord::Base

  has_many :utilisateurs
  has_many :series

  validates_presence_of :nom, :numero
  validates_uniqueness_of :nom, :numero
  validates_numericality_of :numero, :allow_nil => false, :only_integer => true, :greater_than_or_equal_to => 0

end
