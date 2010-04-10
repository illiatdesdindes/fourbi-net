class XmlValidator < ActiveModel::EachValidator

  def validate_each(record, attribute, value)
    begin
      Nokogiri::XML::Document.parse("<?xml version=\"1.0\" encoding=\"UTF-8\"?><content>#{value}</content>", nil, nil, Nokogiri::XML::ParseOptions::STRICT)
    rescue Nokogiri::XML::SyntaxError
      record.errors[attribute] << "#{attribute} n'est pas du xhtml valide"
    end
  end

end