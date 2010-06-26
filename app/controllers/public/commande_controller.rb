class Public::CommandeController < Public::DefaultPublicController

  layout 'public-layout'

  def coordonnees

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

end