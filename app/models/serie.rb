# == Schema Information
#
# Table name: series
#
#  id          :integer         not null, primary key
#  active      :boolean         not null
#  boutique_id :integer         not null
#  nom         :string(255)     not null
#  numero      :integer         not null
#  created_at  :datetime
#  updated_at  :datetime
#

class Serie < ActiveRecord::Base

  belongs_to :boutique

  validates_presence_of :nom, :numero, :boutique_id
  validates_numericality_of :numero, :allow_nil => false, :only_integer => true, :greater_than_or_equal_to => -1

end
