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

end
