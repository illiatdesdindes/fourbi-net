require 'rest_client'

module Paperclip
  module Storage

    # Module that stores images by doing http requests and posting them to another server.
    # Usefull when your app is on heroku and you want to use a cheap hosting plan for your images
    module Http

      SCRIPT_URL = nil

      IMAGES_ROOT_URL = nil

      def self.extended base
      end

      def flush_deletes
        @queued_for_delete.each do |path|
          RestClient.delete "#{SCRIPT_URL}?id=#{path}"
        end
      end

      def flush_writes
        @queued_for_write.each do |style, file|
          RestClient.post SCRIPT_URL, :content => file, :id => path(style)
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

    end
  end
end