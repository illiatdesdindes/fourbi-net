# == Schema Information
#
# Table name: articles
#
#  id                 :integer         not null, primary key
#  description        :text
#  image_content_type :string(255)
#  image_file_name    :string(255)
#  image_file_size    :integer
#  image_updated_at   :datetime
#  nom                :string(255)     not null
#  nombre_restant     :integer         not null
#  numero             :integer         not null
#  prix               :float           not null
#  serie_id           :integer         not null
#  created_at         :datetime
#  updated_at         :datetime
#

class Article < ActiveRecord::Base

  has_attached_file :image, :path => ":class/:attachment/:id.:extension", :url => "#{Paperclip::Storage::Http::IMAGES_ROOT_URL}:class/:attachment/:id.:extension", :storage => :http

  validates_attachment_content_type :image,
                                    :content_type => ['image/gif', 'image/jpeg', 'image/png', 'image/pjpeg',
                                                      'image/x-png']

  validates_attachment_size :image , :less_than => 1000000

  belongs_to :serie

  attr_writer :disponible

  validates_presence_of :nom, :serie_id, :prix, :nombre_restant, :numero
  validates_uniqueness_of :nom
  validates_numericality_of :prix, :allow_nil => true, :greater_than => 0, :message => 'doit être supérieur ou égal à 0'
  validates_numericality_of :nombre_restant, :only_integer => true, :allow_nil => false, :greater_than_or_equal_to => -1
  validates_numericality_of :numero, :allow_nil => false, :only_integer => true, :greater_than_or_equal_to => -1

  has_many :article_clients, :dependent => :delete_all

  def disponible?
    if @disponible.nil?
      numero != -1
    else
      @disponible != '0'
    end
  end

  def before_save
    if nombre_restant == 0
      self.numero = -1
    end
  end

  def Article.prochain_numero serie
    article_max = Article.find(:first, :conditions => ['serie_id = ?', serie], :order => 'numero desc')
    if article_max
      article_max.numero + 1
    else
      0
    end
  end


end
