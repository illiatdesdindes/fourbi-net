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

  CYBERPLUS_SITE_ID = 'cyberplus_site_id'

  CYBERPLUS_CERTIFICAT = 'cyberplus_certificat'

  MAIL_CONFIRMATION_TITRE = 'mail_confirmation_titre'

  MAIL_CONFIRMATION_CONTENU = 'mail_confirmation_contenu'

  def Meta.update_value name, value
    item = Meta[name]
    item.contenu = value
    item.save!
  end

end
