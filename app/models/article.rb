# == Schema Information
#
# Table name: articles
#
#  id                 :integer         not null, primary key
#  description_courte :text
#  description_longue :text
#  image_content_type :string(255)
#  image_file_name    :string(255)
#  nom                :string(255)     not null
#  nombre_restant     :integer         not null
#  numero             :integer         not null
#  prix               :float           not null
#  serie_id           :integer         not null
#  created_at         :datetime
#  updated_at         :datetime
#

class Article < ActiveRecord::Base

  has_attached_file :image,
                    :path => ':class/:attachment/:style/:id.:extension',
                    :storage => :http,
                    :styles => {:terrier_moyen => '128x98',
                                :terrier_petit => '62x79',
                                :desordre_petit => '64x42',
                                :desordre_moyen => '90x58',
                                :image_article => '350x350'}

  validates_attachment_content_type :image,
                                    :content_type => ['image/gif', 'image/jpeg', 'image/png', 'image/pjpeg',
                                                      'image/x-png']

  belongs_to :serie

  attr_writer :disponible

  validates_presence_of :nom, :message => 'Le nom ne doit pas être vide'
  validates_presence_of :prix, :message => 'Le prix ne doit pas être vide'
  validates_presence_of :nombre_restant, :message => 'Le nombre restant ne doit pas être vide'
  validates_presence_of :serie_id, :numero
  validates_uniqueness_of :nom, :message => 'Un article avec ce nom existe déjà'
  validates_numericality_of :prix, :allow_nil => true, :greater_than => 0, :message => 'Le prix doit être supérieur ou égal à 0'
  validates_numericality_of :nombre_restant, :only_integer => true, :allow_nil => false, :greater_than_or_equal_to => -1, :message => 'La valeur du nombre restant est invalide'
  validates_numericality_of :numero, :allow_nil => false, :only_integer => true, :greater_than_or_equal_to => -1
  validates :nom, :xml => true
  validates :description_courte, :xml => true
  validates :description_longue, :xml => true

  has_many :article_clients, :dependent => :delete_all
  has_many :vues, :dependent => :delete_all

  scope :boutique, lambda {|boutique_id| where('series.boutique_id = ?', boutique_id).includes(:serie) }

  scope :serie, lambda { |serie| where('articles.serie_id = ?', serie).order('series.numero desc').includes(:serie) }

  scope :disponible, where('articles.numero != ?', -1).order('articles.numero desc')

  scope :premier_serie, where('articles.numero = ?', 0)

  scope :serie_disponible, where('series.numero != ?', -1).includes(:serie)

  before_save :update_order

  def disponible?
    if @disponible.nil?
      numero != -1
    else
      @disponible != '0'
    end
  end

  def update_order
    if nombre_restant == 0
      self.numero = -1
    end
  end

  def Article.prochain_numero serie
    article_max = Article.where(:serie_id => serie).order('numero desc')
    if article_max.first
      article_max.first.numero + 1
    else
      0
    end
  end


end
