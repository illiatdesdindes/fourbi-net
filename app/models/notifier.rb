class Notifier < ActionMailer::Base

  def send_contact_mail from, to, content
    mail(:from => from,
         :to => to,
         :subject => 'Message de fourbi.net') do |format|
      format.text { render :text => content }
    end
  end

  def send_confirmation_mail from, to, subject, content
    mail(:from => from,
         :to => to,
         :subject => subject) do |format|
      format.text { render :text => content }
    end
  end

end
