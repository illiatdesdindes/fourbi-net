# == Schema Information
#
# Table name: vues
#
#  id                 :integer         not null, primary key
#  article_id         :integer         not null
#  image_content_type :string(255)
#  image_file_name    :string(255)
#  created_at         :datetime
#  updated_at         :datetime
#

class Vue < ActiveRecord::Base

  has_attached_file :image,
                    :path => ":class/:attachment/:id.:extension",
                    :storage => :http

  validates_attachment_content_type :image,
                                    :content_type => ['image/gif', 'image/jpeg', 'image/png', 'image/pjpeg',
                                                      'image/x-png']

  belongs_to :article

end
