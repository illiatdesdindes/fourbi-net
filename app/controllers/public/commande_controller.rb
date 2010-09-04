class Public::CommandeController < Public::DefaultPublicController

  layout 'public-layout'

  Mime::Type.register "application/pdf", :pdf

  include ActionView::Helpers::NumberHelper

  def bon_de_commande
    if session[:client_id]
      client = Client.find(session[:client_id], :include => [:article_clients => :article])
      montant = 10

      document = Prawn::Document.new(:page_size => "A4") do |pdf|
        pdf.font_size = 10

        image_path = "#{Rails.public_path}/images"

        pdf.float do
          pdf.image "#{image_path}/logo.jpg", :at => [0, 800], :position => :left, :vposition => :top, :scale => 1.25
        end

        pdf.float do
          pdf.image "#{image_path}/bulles/bulle003.jpg", :at => [300, 765], :width => 200
        end
        pdf.text_box 'Bon de commande à imprimer ou à recopier', :at => [353, 700], :width => 90, :align => :center

        pdf.float do
          pdf.image "#{image_path}/bulles/bulle002.jpg", :at => [17, 630], :width => 150
        end
        pdf.text_box "Nous avons retenu que vous souhaitiez les articles suivants pour un montant de: #{number_to_currency(montant)}", :at => [40, 600], :width => 110

        pdf.line_width = 3
        pdf.stroke_rectangle [90, 510], 400, 260

        pdf.bounding_box([100, 500], :width => 250, :height => 350) do
          values = client.article_clients.collect { |client_article| [client_article.article.nom, number_to_currency(client_article.prix_unitaire)] }
          pdf.table values, :cell_style => {:border_width => 0}
        end

        pdf.float do
          pdf.image "#{image_path}/bulles/bulle004.jpg", :at => [0, 220], :width => 250
        end
        pdf.text_box 'Votre commande vous sera expédiée à réception de votre chèque', :at => [60, 150], :width => 140, :align => :center

        pdf.line_width = 1
        pdf.stroke_rectangle [270, 220], 250, 100
        pdf.text_box [client.identifiant, client.adresse, "#{client.code_postal} #{client.ville}", Countries::CODE_TO_NAME[client.pays], client.email].join("\n"), :at => [280, 210], :width => 230, :leading => 2

        pdf.text_box 'Merci de libéller vos chèques à l’ordre de Philippe De Jonckheere et les adresser à Philippe De Jonckheere, 92, rue Charles Bassée, 94120 Fontenay-sous-Bois, France',
                     :at => [250, 50], :width => 300

      end
      send_data document.render, :type => Mime::PDF
    else
      redirect_to({:action => :coordonnees}, {:alert => 'Coordonnées non trouvees'})
    end
  end

  def coordonnees
    if session[:panier]
      @page_title = 'fourbi.net: vos coordonnées'
      @coordonnees = {}
      if request.post?
        [:nom, :adresse, :code_postal, :ville, :pays, :email].each do |k|
          @coordonnees[k] = params[k]
        end

        if @coordonnees[:nom].blank?
          flash[:alert] = 'Le nom ne doit pas être vide'
        elsif @coordonnees[:adresse].blank?
          flash[:alert] = 'L\'adresse ne doit pas être vide'
        elsif @coordonnees[:code_postal].blank?
          flash[:alert] = 'Le code postal ne doit pas être vide'
        elsif @coordonnees[:ville].blank?
          flash[:alert] = 'La ville ne doit pas être vide'
        elsif @coordonnees[:pays].blank?
          flash[:alert] = 'Le pays ne doit pas être vide'
        elsif @coordonnees[:email].blank?
          flash[:alert] = 'L\'email nom ne doit pas être vide'
        elsif !EmailVeracity::Address.new(@coordonnees[:email]).valid?
          flash[:alert] = 'L\'email est invalide'
        else
          if session[:client_id]
            client = Client.find(session[:client_id])
            client.article_clients.each do |article_client|
              article_client.delete
            end
          else
            client = Client.new
          end

          client.identifiant = @coordonnees[:nom]
          client.adresse = @coordonnees[:adresse]
          client.code_postal = @coordonnees[:code_postal]
          client.ville = @coordonnees[:ville]
          client.pays = @coordonnees[:pays]
          client.email = @coordonnees[:email]
          client.status= Client::NOUVEAU
          client.prix = 0

          Client.transaction do

            session[:panier].inject(Hash.new { |hash, key| hash[key] = 0 }) do |memo, item|
              memo[item] += 1
              memo
            end.each_pair do |item_id, quantite|
              article = Article.find(item_id)
              article_client = ArticleClient.new
              article_client.client = client
              article_client.article = article
              article_client.quantite = quantite
              article_client.prix_unitaire = article.prix
              client.article_clients << article_client
              client.prix += quantite * article.prix
            end
            if client.save
              session[:client_id] = client.id
              redirect_to :action => :validation
            else
              flash[:alert] = client.errors.full_messages[0]
            end
          end
        end
      else
        if session[:client_id]
          client = Client.find(session[:client_id])
          @coordonnees[:nom] = client.identifiant
          @coordonnees[:adresse] = client.adresse
          @coordonnees[:code_postal] = client.code_postal
          @coordonnees[:ville] = client.ville
          @coordonnees[:pays] = client.pays
          @coordonnees[:email] = client.email
        else
          @coordonnees[:pays] = 'FR'
        end
      end
    else
      redirect_to({:controller => 'public/index', :action => :sommaire}, {:alert => 'Votre panier est vide'})
    end
  end

  def panier
    @panier = session[:panier] || []
    if request.post?
      if params[:add]
        article = Article.find(params[:add].to_i)
        if article
          @panier << article.id
          session[:panier] = @panier
          redirect_to({:action => :panier}, {:notice => "L'article \"#{article.nom}\" a été ajouté à votre panier"})
        else
          redirect_to({:action => :panier}, {:alert => 'Article non trouvé'})
        end
      elsif params[:remove]
        if i = @panier.index(params[:remove].to_i)
          @panier.delete_at i
          session[:panier] = @panier
          redirect_to({:action => :panier}, {:notice => 'L\'article a été supprimé de votre panier'})
        else
          redirect_to({:action => :panier}, {:alert => 'Article non trouvé'})
        end
      else
        redirect_to({:action => :panier})
      end
    else
      @custom_css = 'body { background-image: url("/images/fonds/panier.jpg"); background-repeat: no-repeat; }'
      @page_title = 'fourbi.net: votre panier'
      @panier_contenu = Article.where(:id => @panier).includes(:serie => :boutique).inject({}) do |result, article|
        result[article.id] = article
        result
      end
    end
  end

  def validation
    if session[:client_id]
      @client = Client.find(session[:client_id])
    else
      redirect_to({:action => :coordonnees}, {:alert => 'Coordonnées non trouvees'})
    end
  end

end