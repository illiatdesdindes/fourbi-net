class ApplicationController < ActionController::Base

  session_times_out_in 10.minutes, :after_timeout => :when_session_times_out

  protect_from_forgery

  after_filter :set_content_type

  def set_content_type
    if (response.content_type == 'text/html') && request.accepts.include?('application/xml')
      response.content_type = 'application/xhtml+xml'
    end
  end

  private

  def when_session_times_out
    flash[:alert] = 'Votre session a été déconnectée'
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

