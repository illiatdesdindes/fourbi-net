# Simplifie l'ecriture d'application rails utilisant l'API Cyberplus de la Banque Populaire.
# http://www.cyberpaiement.tm.fr/
# Copyright (c) 2009-2010 Julien Kirch, released under the MIT license

require 'digest/sha1'

class Cyberplus

  Cyberplus::CYBERPLUS_SITE_ID = ENV['CYBERPLUS_SITE_ID']

  Cyberplus::CYBERPLUS_CERTIFICAT = ENV['CYBERPLUS_CERTIFICAT']

  Cyberplus::CYBERPLUS_CTX_MODE = ENV['CYBERPLUS_CTX_MODE']

  CHAMPS_OBLIGATOIRES = [:amount,
                         :payment_cards,
                         :payment_config,
                         :trans_id,
                         :validation_mode,
                         :trans_date]

  CHAMPS_FACULTATIFS_A_RECOPIER = [:cust_email,
                                   :cust_id,
                                   :cust_name,
                                   :cust_phone,
                                   :cust_title,
                                   :cust_city,
                                   :cust_zip,
                                   :cust_address,
                                   :language,
                                   :order_id,
                                   :order_info,
                                   :cust_country,
                                   :url_success,
                                   :url_referral,
                                   :url_refused,
                                   :url_cancel,
                                   :url_error,
                                   :url_return]

  URL_PLATEFORME = 'https://systempay.cyberpluspaiement.com/vads-payment/'

  # Calcule les paramètres du formulaire
  def Cyberplus.calculer_params params
    CHAMPS_OBLIGATOIRES.each do |nom_champ|
      unless params.has_key? nom_champ
        raise "La valeur \"#{nom_champ}\" est manquante dans les paramètres"
      end
    end

    result = {}

    result[:vads_amount] = check_integer params, :amount

    result[:vads_capture_delay] = (params.has_key? :capture_delay) ? check_integer(params, :capture_delay) : 0

    result[:vads_currency] = (params.has_key? :currency) ? check_integer_and_length(params, :currency, 3) : 978

    result[:vads_cust_country] = check_integer_and_length(params, :cust_country, 2) if params.has_key? [:cust_country]

    unless ['TEST', 'PRODUCTION'].include? CYBERPLUS_CTX_MODE
      raise "La valeur du mode \"#{CYBERPLUS_CTX_MODE}\" est invalide"
    else
      result[:vads_ctx_mode] = CYBERPLUS_CTX_MODE
    end

    payment_config = params[:payment_config]
    if payment_config == 'SINGLE'
      result[:vads_payment_config] = 'SINGLE'
    else
      if payment_config.index('MULTI') == 0
        result[:vads_payment_config] = payment_config
      else
        raise "La valeur du mode de paiement \"#{payment_config}\" est invalide"
      end
    end


    if CYBERPLUS_SITE_ID.nil?
      raise 'CYBERPLUS_SITE_ID est vide'
    elsif CYBERPLUS_SITE_ID.size != 8
      raise 'CYBERPLUS_SITE_ID est invalide car il devrait avoir 8 caractères de long'
    else
      result[:vads_site_id] = CYBERPLUS_SITE_ID
    end

    if CYBERPLUS_CERTIFICAT.nil?
      raise 'CYBERPLUS_CERTIFICAT est vide'
    end

    result[:vads_trans_date] = params[:trans_date].strftime '%Y%m%d%H%M%S'

    result[:vads_trans_id] = check_integer_and_length params, :trans_id, 6

    validation_mode = check_integer params, :validation_mode

    result[:vads_payment_cards] = params[:payment_cards]

    unless [0, 1].include? validation_mode.to_i
      raise "La valeur du validation_mode \"#{validation_mode}\" est invalide"
    else
      result[:vads_validation_mode] = validation_mode
    end

    CHAMPS_FACULTATIFS_A_RECOPIER.each do |nom_champ|
      if params.has_key? nom_champ
        result[('vads_' + nom_champ.to_s).to_sym] = params[nom_champ]
      end
    end

    result[:vads_return_mode] = 'NONE'
    result[:vads_action_mode] = 'INTERACTIVE'
    result[:vads_page_action] = 'PAYMENT'
    result[:vads_version] = 'V2'

    keys = []
    result.each_key do |key|
      keys << key.to_s
    end
    keys.sort!

    values = []
    keys.each do |key|
      values << result[key.to_sym]
    end

    result[:signature] = Digest::SHA1.hexdigest("#{values.join('+')}+#{CYBERPLUS_CERTIFICAT}")

    result

  end

  def Cyberplus.verifier_params params
    keys = []
    params.each_key do |key|
      if key.index('vads_') == 0
        keys << key.to_s
      end
    end
    keys.sort!

    values = []
    keys.each do |key|
      values << params[key]
    end

    signature = Digest::SHA1.hexdigest("#{values.join('+')}+#{CYBERPLUS_CERTIFICAT}")

    if signature.to_s != params[:signature]
      raise "La signature est invalide !"
    end

  end

  private

  # Vérifie qu'un paramètre est un entier et a la bonne longueur
  def Cyberplus.check_integer_and_length params, name, length
    result = check_integer params, name
    if params[name].nil?
      raise "Le champ #{name} est vide"
    elsif params[name].size != length
      raise "La longueur du champ #{name} \"#{result}\" est invalide car il devrait être de #{length}"
    else
      params[name]
    end
  end

  def Cyberplus.check_integer params, name
    valeur_sans_prefixe = params[name].to_s.sub(/\A0+/, '')

    # si il n'y a que des 0 c'est bon
    unless valeur_sans_prefixe.empty?
      begin
        Integer valeur_sans_prefixe
      rescue ArgumentError
        raise "La valeur du champ #{name} \"#{params[name]}\" est invalide"
      end
    end
  end

end