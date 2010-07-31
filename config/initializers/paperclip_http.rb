module Paperclip

  module Storage

    # Module that stores images by doing http requests and posting them to another server.
    # Usefull when your app is on heroku and you want to use a cheap non-ruby hosting plan for your images
    module Http

      Paperclip::Storage::Http::IMAGES_ROOT_URL = ENV['PAPERCLIP_IMAGES_ROOT_URL']

      Paperclip::Storage::Http::SCRIPT_URL = ENV['PAPERCLIP_SCRIPT_URL']

      Paperclip::Storage::Http::USER = ENV['PAPERCLIP_USER']

      Paperclip::Storage::Http::PASSWORD = ENV['PAPERCLIP_PASSWORD']

      def self.extended base
        base.instance_eval do
          @url = ":path_url"
        end
        Paperclip.interpolates(:path_url) do |attachment, style|
          "#{Paperclip::Storage::Http::IMAGES_ROOT_URL}#{attachment.path(style)}"
        end

      end

      def flush_deletes
        @queued_for_delete.each do |path|
          RestClient::Request.execute(:method => :delete, :url => "#{SCRIPT_URL}?id=#{path}", :user => USER, :password => PASSWORD)
        end
      end

      def flush_writes
        @queued_for_write.each do |style, file|
          RestClient::Request.execute(:method => :post, :url => SCRIPT_URL, :payload => {:content => file, :id => path(style)}, :user => USER, :password => PASSWORD)
        end
      end

      def exists?(style = default_style)
        begin
          RestClient.head "#{IMAGES_ROOT_URL}#{path(style)}"
          return true
        rescue RestClient::ResourceNotFound
          return false
        end
      end

      def to_file style = default_style
        file = Tempfile.new(path(style))
        file.write(RestClient.get "#{IMAGES_ROOT_URL}#{path(style)}")
        file.rewind
        return file
      end

    end
  end
end
