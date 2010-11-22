class Public::RetourController < Public::DefaultPublicController

  layout 'public-layout'

  skip_before_filter :verify_authenticity_token

  def rappel
    Cyberplus::verifier_params params
    @client = Client.find(params[:vads_order_id])
    unless @client.cyberplus_verification_banque

      # on met à jour le client
      mettre_a_jour_cyberplus
      @client.save!

      # on envoie des mails
      mail_client
      mail_fourbi
    end
    render :text => "OK"
  end

  def paiement_echec
  end

  def paiement_succes
  end

  private

  def mettre_a_jour_cyberplus
    @client.cyberplus_auth_result = params[:vads_auth_result]
    @client.cyberplus_auth_mode = params[:vads_auth_mode]
    @client.cyberplus_auth_number = params[:vads_auth_number]
    @client.cyberplus_card_number = params[:vads_card_number]
    @client.cyberplus_warranty_result = params[:vads_warranty_result]
    @client.cyberplus_payment_certificate = params[:vads_payment_certificate]
    @client.cyberplus_result = params[:vads_result]
    @client.cyberplus_extra_result = params[:vads_extra_result]
    @client.cyberplus_verification_banque = true
    @client.methode_paiement = Client::PAIEMENT_EN_LIGNE

    if params[:vads_result] == '00'
      @client.status = Client::PAYE
    else
      @client.statut= Client::REFUSE
    end
  end

  def mail_client
    subject = "[fourbi.net] Commande n°#{@client.id}"
    body = render_to_string :file => "public/retour/mail_client.erb", :layout => false
    MailHttp.send_mail Meta[Meta::EMAIL_CONTACT].contenu, @client.email, subject, body
  end

  def mail_fourbi
    subject = "[fourbi.net] Paiement de la commande n°#{@client.id}"
    body = render_to_string :file => "public/retour/mail_fourbi.erb", :layout => false
    MailHttp.send_mail Meta[Meta::EMAIL_CONTACT].contenu, Meta[Meta::EMAIL_CONTACT].contenu, subject, body
  end


end
