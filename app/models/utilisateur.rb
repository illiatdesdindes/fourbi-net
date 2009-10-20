# == Schema Information
#
# Table name: utilisateurs
#
#  id              :integer         not null, primary key
#  boutique_id     :integer
#  email           :string(40)      not null
#  hashed_password :string(255)     not null
#  login           :string(20)      not null
#  nom             :string(40)      not null
#  salt            :string(255)     not null
#  site_admin      :boolean
#  created_at      :datetime
#  updated_at      :datetime
#

require 'digest/sha1'

class Utilisateur < ActiveRecord::Base

  validates_presence_of :login, :nom
  validates_uniqueness_of :login, :nom
  validates_confirmation_of :mot_de_passe, :message => 'invalide.'

  has_one :boutique

  attr_accessor :confirmation_mot_de_passe

  def validate
    errors.add_to_base("Mot de passe manquant") if hashed_password.blank?
    unless EmailVeracity::Address.new(email).valid?
      errors.add(:email, 'L\'adresse email est invalide')
    end
  end

  def Utilisateur.authenticate(login, password)
    user = Utilisateur.find_by_login(login)
    if user
      expected_password = encrypted_password(password, user.salt)
      if user.hashed_password != expected_password
        user = nil
      end
    end
    user
  end

  # 'mot_de_passe' is a virtual attribute
  def mot_de_passe
    @mot_de_passe
  end

  def mot_de_passe=(pwd)
    @mot_de_passe = pwd
    return if pwd.blank?
    create_new_salt
    self.hashed_password = Utilisateur.encrypted_password(self.mot_de_passe, self.salt)
  end

  private

  def Utilisateur.encrypted_password(password, salt)
    string_to_hash = password + "bargh" + salt
    Digest::SHA1.hexdigest(string_to_hash)
  end

  def create_new_salt
    self.salt = self.object_id.to_s + rand.to_s
  end

end
