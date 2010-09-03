class Notifier < ActionMailer::Base

  def send_contact_mail from, to, content
    mail(:from => from,
         :to => to,
         :subject => 'Message de fourbi.net') do |format|
      format.text { render :text => content }
    end
  end

end
