class Public::RetourController < Public::DefaultPublicController

  skip_before_filter :verify_authenticity_token


  def rappel
    Cyberplus::verifier_params params

    client = Client.find(params[:vads_order_id])
    mettre_a_jour_cyberplus client
    client.cyberplus_verification_banque = true
    client.methode_paiement = Client::PAIEMENT_EN_LIGNE

    if params[:vads_result] == '00'
      client.status = Client::PAYE
    else
      client.statut= Client::REFUSE
    end
    client.save!
    render :text => "OK"
  end

  def paiement_echec

  end

  def paiement_succes

  end

  private

  def mettre_a_jour_cyberplus client
    client.cyberplus_auth_result = params[:vads_auth_result]
    client.cyberplus_auth_mode = params[:vads_auth_mode]
    client.cyberplus_auth_number = params[:vads_auth_number]
    client.cyberplus_card_number = params[:vads_card_number]
    client.cyberplus_warranty_result = params[:vads_warranty_result]
    client.cyberplus_payment_certificate = params[:vads_payment_certificate]
    client.cyberplus_result = params[:vads_result]
    client.cyberplus_extra_result = params[:vads_extra_result]
  end


end
