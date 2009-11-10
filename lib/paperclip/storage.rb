require 'rest_client'

module Paperclip
  module Storage

    # Module that stores images by doing http requests and posting them to another server.
    # Usefull when your app is on heroku and you want to use a cheap non-ruby hosting plan for your images
    module Http

      # SCRIPT_URL = nil

      # IMAGES_ROOT_URL = nil

      # USER = nil

      # PASSWORD = nil

      def self.extended base
        raise "No script url provided" unless Paperclip::Storage::Http::SCRIPT_URL
        raise "No images root url provided" unless Paperclip::Storage::Http::IMAGES_ROOT_URL
        RAILS_DEFAULT_LOGGER.error "Script url : \"#{Paperclip::Storage::Http::SCRIPT_URL}\""
        RAILS_DEFAULT_LOGGER.error "Images root url : \"#{Paperclip::Storage::Http::IMAGES_ROOT_URL}\""
      end

      def flush_deletes
        @queued_for_delete.each do |path|
          RestClient.delete "#{Paperclip::Storage::Http::SCRIPT_URL}?id=#{path}", get_params
        end
      end

      def flush_writes
        @queued_for_write.each do |style, file|
          RestClient.post Paperclip::Storage::Http::SCRIPT_URL, {:content => file, :id => path(style)}, get_params
        end
      end

      def exists?(style = default_style)
        begin
          RestClient.head "#{Paperclip::Storage::Http::IMAGES_ROOT_URL}#{path(style)}"
          return true
        rescue RestClient::ResourceNotFound
          return false
        end
      end

      private

      def get_params
        if Paperclip::Storage::Http::USER && Paperclip::Storage::Http::PASSWORD
          {:user => Paperclip::Storage::Http::USER, :password => Paperclip::Storage::Http::PASSWORD}
        else
          {}
        end
      end

    end
  end
end