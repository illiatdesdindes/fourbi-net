class Admin::ClientsController < Admin::DefaultAdminController

  layout 'admin-layout'
  before_filter :authorize_base

  def attente_envoi
    @clients = Client.attente_envoi(:all, :include => [{:article_clients => :articles}])
    @page_title = 'Liste des clients en attente d\'envoi'
    render :template => 'admin/clients/index'
  end

  def attente_paiement
    @clients = Client.attente_paiement(:all, :include => [{:article_clients => :articles}])
    @page_title = 'Liste des clients en attente de paiement'
    render :template => 'admin/clients/index'
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
          flash[:notice] = "client \"#{@client.identifiant}\" modifié"
          redirect_to :action => :show, :id => @client
        else
          clean_changes
          flash[:error] = "Client \"#{@client.identifiant}\" non modifié : #{@client.errors.full_messages[0]}"
          @boutiques = Boutique.find(:all, :order => 'nom')
          @boutiques = Boutique.find(:all, :order => 'numero asc', :include => [:series => :articles])
          @page_title = "Modifier client \"#{@client.identifiant}\""
        end
      end
    else
      @client = Client.find(params[:id])
      @boutiques = Boutique.find(:all, :order => 'numero asc', :include => [:series => :articles])
      @page_title = "Modifier client \"#{@client.identifiant}\""
    end
  end

  def index
    @clients = Client.paginate(:all, :order => 'status desc, id', :per_page => 50, :page => params[:page], :include => [{:article_clients => :article}])
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
          flash[:notice] = "Client \"#{@client.identifiant}\" créé-e"
          redirect_to :action => :show, :id => @client
        else
          @page_title = 'Créer un client'
          @boutiques = Boutique.find(:all, :order => 'numero asc', :include => [:series => :articles])
        end
      end
    else
      @client = Client.new
      @client.pays = 'FR'
      @boutiques = Boutique.find(:all, :order => 'numero asc', :include => [:series => :articles])
    end
  end

  def search

  end

  def show
    begin
      @client = Client.find(params[:id], :include => [:article_clients => :article ])
      @boutiques = Boutique.find(:all, :order => 'numero asc', :include => [:series => :articles])
    rescue ActiveRecord::RecordNotFound
      flash[:error] = "Le client-e numéro #{params[:id]} n'existe pas"
      redirect_to :action => :index
    end
  end

end

