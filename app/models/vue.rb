# == Schema Information
#
# Table name: vues
#
#  id                 :integer         not null, primary key
#  article_id         :integer         not null
#  image_content_type :string(255)
#  image_file_name    :string(255)
#  image_file_size    :integer
#  image_updated_at   :datetime
#  created_at         :datetime
#  updated_at         :datetime
#

class Vue < ActiveRecord::Base

  has_attached_file :image, :path => ":class/:attachment/:id.:extension", :url => "#{Paperclip::Storage::Http::IMAGES_ROOT_URL}:class/:attachment/:id.:extension", :storage => :http

  validates_attachment_content_type :image,
                                    :content_type => ['image/gif', 'image/jpeg', 'image/png', 'image/pjpeg',
                                                      'image/x-png']

  validates_attachment_size :image , :less_than => 1000000

  belongs_to :article

end
