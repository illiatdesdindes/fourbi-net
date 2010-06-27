# == Schema Information
#
# Table name: metas
#
#  id      :integer         not null, primary key
#  contenu :text            not null
#  nom     :string(255)     not null
#

class Meta < ActiveRecord::Base

  validates_presence_of :nom, :contenu

  def Meta.[] nom
    result = Meta.where(:nom => nom).first
    if result
      result
    else
      result = Meta.new
      result.nom = nom
      return result
    end
  end

  CGV = 'cgv'

  EMAIL_DESORDRE = 'email_desordre'

  EMAIL_TERRIER = 'email_terrier'

  def Meta.update_value name, value
    item = Meta[name]
    item.contenu = value
    item.save!
  end

end
