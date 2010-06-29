class Public::CommandeController < Public::DefaultPublicController

  layout 'public-layout'

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
      redirect_to({:controller => 'public/index', :action => :index}, {:alert => 'Votre panier est vide'})
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
      @custom_css = 'body { background-image: url("/images/fonds/panier.jpg"); }'
      @page_title = 'fourbi.net: votre panier'
      @panier_contenu = Article.where(:id => @panier).inject({}) do |result, article|
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