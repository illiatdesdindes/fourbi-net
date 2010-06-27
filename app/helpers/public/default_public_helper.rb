module Public::DefaultPublicHelper

  def url_timbre
    "timbres/#{sprintf('%03d', (rand(39) + 1))}.jpg"
  end

end
