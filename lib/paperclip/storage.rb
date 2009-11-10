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
        raise "No script url provided" unless SCRIPT_URL
        raise "No images root url provided" unless IMAGES_ROOT_URL
        raise "No user provided" unless USER
        raise "No password provided" unless PASSWORD
        RAILS_DEFAULT_LOGGER.warn "Script url : \"#{Paperclip::Storage::Http::SCRIPT_URL}\""
        RAILS_DEFAULT_LOGGER.warn "Images root url : \"#{Paperclip::Storage::Http::IMAGES_ROOT_URL}\""
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

    end
  end
end