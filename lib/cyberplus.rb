# Simplifie l'ecriture d'application rails utilisant l'API Cyberplus de la Banque Populaire.
# http://www.cyberpaiement.tm.fr/
# Copyright (c) 2009-2010 Julien Kirch, released under the MIT license

require 'digest/sha1'

class Cyberplus

  Cyberplus::CYBERPLUS_SITE_ID = ENV['CYBERPLUS_SITE_ID']

  Cyberplus::CYBERPLUS_CERTIFICAT = ENV['CYBERPLUS_CERTIFICAT']

  CHAMPS_OBLIGATOIRES = [:amount, :ctx_mode, :payment_cards, :payment_config, :trans_id, :validation_mode, :trans_date]

  CHAMPS_FACULTATIFS_A_RECOPIER = [:cust_email, :cust_id, :cust_name, :cust_phone, :cust_title, :cust_city, :cust_zip, :cust_address, :language, :order_id, :order_info, :cust_country, :url_success, :url_referral, :url_refused, :url_cancel, :url_error, :url_return]

  CHAMPS_CLE_ALLER = [:site_id, :ctx_mode, :trans_id, :trans_date, :validation_mode, :capture_delay, :payment_config, :payment_cards, :amount, :currency]

  CHAMPS_CLE_RETOUR = [:site_id, :ctx_mode, :trans_id, :trans_date, :validation_mode, :capture_delay, :payment_config, :card_brand, :card_number, :amount, :currency, :auth_mode, :auth_result, :auth_number, :warranty_result, :payment_certificate, :result]

  CHAMP_A_VERIFIER = [:capture_delay, :validation_mode]

  URL_PLATEFORME = 'https://systempay.cyberpluspaiement.com/vads-payment/'

  # Calcule les paramètres du formulaire
  def Cyberplus.calculer_params params
    CHAMPS_OBLIGATOIRES.each do |nom_champ|
      unless params.has_key? nom_champ
        raise "La valeur \"#{nom_champ}\" est manquante dans les paramètres"
      end
    end

    result = {}

    result[:amount] = check_integer params, :amount

    result[:capture_delay] = (params.has_key? :capture_delay) ? check_integer(params, :capture_delay) : 0

    result[:currency] = (params.has_key? :currency) ? check_integer_and_length(params, :currency, 3) : 978

    result[:cust_country] = check_integer_and_length(params, :cust_country, 2) if params.has_key? [:cust_country]

    unless [:TEST, :PRODUCTION, 'TEST', 'PRODUCTION'].include? params[:ctx_mode]
      raise "La valeur du mode \"#{params[:ctx_mode]}\" est invalide"
    else
      result[:ctx_mode] = params[:ctx_mode]
    end

    payment_config = params[:payment_config]
    if payment_config == 'SINGLE'
      result[:payment_config] = 'SINGLE'
    else
      if payment_config.index('MULTI') == 0
        result[:payment_config] = payment_config
      else
        raise "La valeur du mode de paiement \"#{payment_config}\" est invalide"
      end
    end


    if CYBERPLUS_SITE_ID.nil?
      raise 'CYBERPLUS_SITE_ID est vide'
    elsif CYBERPLUS_SITE_ID.size != 8
      raise 'CYBERPLUS_SITE_ID est invalide car il devrait avoir 8 caractères de long'
    else
      result[:site_id] = CYBERPLUS_SITE_ID
    end

    if CYBERPLUS_CERTIFICAT.nil?
      raise 'CYBERPLUS_CERTIFICAT est vide'
    end

    result[:trans_date] = params[:trans_date].strftime '%Y%m%d%H%M%S'

    result[:trans_id] = check_integer_and_length params, :trans_id, 6

    validation_mode = check_integer params, :validation_mode

    result[:payment_cards] = params[:payment_cards]

    unless [0, 1].include? validation_mode.to_i
      raise "La valeur du validation_mode \"#{validation_mode}\" est invalide"
    else
      result[:validation_mode] = validation_mode
    end

    result[:version] = 'V1'

    signature = 'V1'
    CHAMPS_CLE_ALLER.each do |champ|
      if result.has_key? champ
        signature << "+#{result[champ]}"
      elsif params.has_key? champ
        signature << "+#{params[champ]}"
      else
        raise "Cle non trouvée \"#{champ}\""
      end
    end
    signature << "+#{CYBERPLUS_CERTIFICAT}"
    result[:signature] = Digest::SHA1.hexdigest signature

    CHAMPS_FACULTATIFS_A_RECOPIER.each do |nom_champ|
      if params.has_key? nom_champ
        result[nom_champ] = params[nom_champ]
      end
    end

    result

  end

  def Cyberplus.verifier_params params_resultat, params_originaux
    params_originaux[:currency] = 978 unless params_originaux.has_key? :currency
    params_originaux[:capture_delay] = 0 unless params_originaux.has_key? :capture_delay

    (CHAMP_A_VERIFIER).each do |nom_champ|
      if params_originaux.has_key? nom_champ
        if params_resultat[nom_champ].to_s != params_originaux[nom_champ].to_s
          raise "La valeur du paramètre #{nom_champ} est différente : \"#{params_originaux[nom_champ]}\" -> \"#{params_resultat[nom_champ]}\""
        end
      end
    end

    signature = 'V1'
    CHAMPS_CLE_RETOUR.each do |champ|
      signature << "+#{params_resultat[champ]}"
    end

    if params_resultat.has_key? :hash
      signature << "+#{params_resultat[:hash]}"
    end
    signature << "+#{CYBERPLUS_CERTIFICAT}"

    signature_calculee = Digest::SHA1.hexdigest signature

    if signature_calculee.to_s != params_resultat[:signature].to_s
      raise "La signature est invalide : \"#{signature_calculee}\" -> \"#{params_resultat[:signature]}\""
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