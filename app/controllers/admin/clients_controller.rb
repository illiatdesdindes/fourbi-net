class Admin::ClientsController < Admin::DefaultAdminController

  layout 'admin-layout'
  before_filter :authorize_base

  def article
    article = Article.find(params[:id])
    article_clients = ArticleClient.where(:article_id => article).includes(:article, :client)
    @clients = article_clients.collect{|article_client| article_client.client}.find_all{|client| client.status != Client::SUPPRIME}
    @page_title = "Liste des clients ayant commandé \"#{article.nom}\""
    render :action => :index
  end

  def attente_envoi
    @clients = Client.attente_envoi.includes([{:article_clients => :articles}])
    @page_title = 'Liste des clients en attente d\'envoi'
    render :action => :index
  end

  def attente_paiement
    @clients = Client.attente_paiement.includes([{:article_clients => :articles}])
    @page_title = 'Liste des clients en attente de paiement'
    render :action => :index
  end

  def cheque_recu
    @client = Client.find(params[:id]).includes([:article_clients => :article ])
    if @client.status == Client::NOUVEAU
      @client.status = Client::PAIEMENT_CHEQUE
      @client.save!
      flash[:notice] = "Client \"#{@client.identifiant}\" modifié"
    else
      flash[:alert] = "Le client \"#{@client.identifiant}\" n'est pas dans un status compatible avec la réception d'un chèque"
    end
    redirect_to :action => :show, :id => @client
  end

  def commande_envoyee
    @client = Client.find(params[:id]).includes([:article_clients => :article ])
    if @client.status == Client::PAIEMENT_CHEQUE || @client.status == Client::PAIEMENT_EN_LIGNE
      @client.date_envoi = DateTime.now
      @client.save!
      flash[:notice] = "Client \"#{@client.identifiant}\" modifié"
    else
      flash[:alert] = "Le client \"#{@client.identifiant}\" n'est pas dans un status compatible avec l'envoi de sa commande"
    end
    redirect_to :action => :show, :id => @client
  end

  def edit
    if request.put?
      @client = Client.find(params[:id])
      @client.attributes = params[:client]
      set_changes = @client.changed
      Client.transaction do
        params[:article].each do |id, nombre|
          article = Article.find(id)
          nombre_i = nombre.to_i
          if nombre_i != 0
            # on a choisi des articles
            if article_client = @client.article_clients.detect{|article_client| article_client.article == article}
              # on en avait déjà commandé
              if article_client.quantite != nombre_i
                @client.prix += (nombre_i - article_client.quantite) * article_client.prix_unitaire
                article_client.quantite = nombre_i
              end
            else
              # on n'en avait pas déjà commandé
              article_client = ArticleClient.new
              article_client.client = @client
              article_client.article = article
              article_client.quantite = nombre_i
              article_client.prix_unitaire = article.prix
              @client.article_clients << article_client
              @client.prix += nombre_i * article.prix
            end
          elsif article_client = @client.article_clients.detect{|article_client| article_client.article == article}
            # on en avait commandé mais plus maintenant
            @client.prix -= article_client.quantite * article_client.prix_unitaire
            article_client.mark_for_destruction
          end
        end
        if @client.save
          redirect_to({:action => :show, :id => @client}, {:notice => "Client \"#{@client.identifiant}\" modifié"})
        else
          clean_changes
          flash[:alert] = "Client \"#{@client.identifiant}\" non modifié : #{@client.errors.full_messages[0]}"
          @boutiques = Boutique.order('nom asc')
          @boutiques = Boutique.order('numero asc').includes([:series => :articles])
          @page_title = "Modifier client \"#{@client.identifiant}\""
        end
      end
    else
      @client = Client.find(params[:id])
      @boutiques = Boutique.order('numero asc').includes([:series => :articles])
      @page_title = "Modifier client \"#{@client.identifiant}\""
    end
  end

  def index
    @clients = Client.paginate(:per_page => 50, :page => params[:page], :order => 'status desc, id', :include => [{:article_clients => :article}])
    @page_title = 'Liste des clients'
  end

  def new
    if request.post?
      @client = Client.new(params[:client])
      @client.status= Client::NOUVEAU
      @client.prix = 0
      Client.transaction do
        params[:article].each do |id, nombre|
          nombre_i = nombre.to_i
          if nombre_i != 0
            article = Article.find(id)
            article_client = ArticleClient.new
            article_client.client = @client
            article_client.article = article
            article_client.quantite = nombre_i
            @client.article_clients << article_client
            @client.prix += nombre_i * article.prix
          end
        end
        if @client.save
          redirect_to({:action => :show, :id => @client}, {:notice => "Client \"#{@client.identifiant}\" créé-e"})
        else
          @page_title = 'Créer un client'
          @boutiques = Boutique.order('numero asc').includes([:series => :articles])
        end
      end
    else
      @client = Client.new
      @client.pays = 'FR'
      @boutiques = Boutique.order('numero asc').includes([:series => :articles])
    end
  end

  def search
    query = "(identifiant ilike ? or adresse ilike ?)"
    unless params[:supprime]
      query << "and status != '#{Client::SUPPRIME}'"
    end
    search_param = "%" + params[:search].upcase + "%"
    @clients = Client.where([query, search_param, search_param]).order('identifiant asc')
    if @clients.size == 1
      redirect_to :action => :show, :id => @clients[0]
    else
      render :action => :index
    end
  end

  def show
    begin
      @client = Client.find(params[:id]).includes([:article_clients => :article ])
      @boutiques = Boutique.order('numero asc').includes([:series => :articles])
      @page_title = "Voir client \"#{@client.identifiant}\""
    rescue ActiveRecord::RecordNotFound
      redirect_to({:action => :index}, {:alert => "Le client numéro #{params[:id]} n'existe pas"})
    end
  end

end

