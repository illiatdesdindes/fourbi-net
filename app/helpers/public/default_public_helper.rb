module Public::DefaultPublicHelper

  def url_timbre
    "timbres/#{sprintf('%03d', (rand(39) + 1))}.jpg"
  end

  def url_question
    "questions/#{sprintf('%03d', (rand(3) + 1))}.jpg"
  end

  def javascript_pop_up url, params = {}
    {:location => false, :menubar => false, :personalbar => false, :titlebar => false, :resizable => true, :scrollbars => true}.each_pair do |key, value|
      params[key] ||= value
    end
    params_array = []
    params.each_pair do |key, value|
      if value.is_a? TrueClass
        value_text = 'yes'
      elsif value.is_a? TrueClass
        value_text = 'no'
      else
        value_text = value.to_s
      end
      params_array << ["#{key.to_s}=#{value_text}"]
    end
    raw "javascript:window.open('#{url}', 'Zoom', '#{params_array.join(',')}');"
  end

end
