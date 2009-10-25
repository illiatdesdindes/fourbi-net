# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base

  helper :all # include all helpers, all the time

  protect_from_forgery # See ActionController::RequestForgeryProtection for details

  # Scrub sensitive parameters from your log
  # filter_parameter_logging :password

  after_filter :set_content_type

  def set_content_type
    if (response.content_type == 'text/html') && request.accepts.include?('application/xml')
      response.content_type = 'application/xhtml+xml'
    end
  end

end

class TrueClass
  def to_fs
    "oui"
  end
end

class FalseClass
  def to_fs
    "non"
  end
end