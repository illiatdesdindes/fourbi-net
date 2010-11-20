module MailHttp

  MailHttp::SCRIPT_URL = ENV['MAIL_SCRIPT_URL']

  MailHttp::USER = ENV['MAIL_USER']

  MailHttp::PASSWORD = ENV['MAIL_PASSWORD']

  def MailHttp.send_mail from, to, subject, body
    RestClient::Request.execute(:method => :post,
                                :url => SCRIPT_URL,
                                :payload =>
                                        {:mailFrom => from,
                                         :mailTo => to,
                                         :subject => subject,
                                         :body => body},
                                :user => USER,
                                :password => PASSWORD)
  end


end