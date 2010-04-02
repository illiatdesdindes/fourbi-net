require 'rubygems'
require 'sinatra'
include FileUtils

PATH_TO_IMAGES= '../tmp/images'

unless File.exists? PATH_TO_IMAGES
  mkdir_p PATH_TO_IMAGES
end

set :public, PATH_TO_IMAGES
set :port, 4567

delete '/script' do
  target_file = "#{PATH_TO_IMAGES}/#{params[:id]}"
  if File.exists? target_file
    File.delete target_file
  end
end

post '/script' do
  target_file = "#{PATH_TO_IMAGES}/#{params[:id]}"
  target_directory = File.dirname target_file
  unless File.exists? target_directory
    mkdir_p target_directory
  end
  copy_file params[:content][:tempfile].path, target_file
end

