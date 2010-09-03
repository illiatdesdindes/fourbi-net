class Public::ContactController < Public::DefaultPublicController

  layout 'public-layout'

  def index
    @page_title = 'fourbi.net, nous contacter'
  end

  def desordre
    @page_title = 'fourbi.net, contacter Philippe De Jonckheere'
    @logo_path = 'contact/logo_desordre.jpg'
    contact Meta::EMAIL_TERRIER
  end

  def terrier
    @page_title = 'fourbi.net, contacter L.L de Mars'
    @logo_path = 'contact/logo_terrier.gif'
    contact Meta::EMAIL_DESORDRE
  end

  private

  def contact email_meta_name
    if request.post?
      @email = params[:email]
      @message = params[:message]
      if @email.blank?
        flash[:alert] = 'L\'adresse email est vide'
        render :contact
      elsif (! EmailVeracity::Address.new(@email).valid? )
        flash[:alert] = 'L\'adresse email est invalide'
        render :contact
      elsif @message.blank?
        flash[:alert] = 'Le message est vide'
        render :contact
      else
        if (to = Meta[email_meta_name].contenu).blank?
          flash[:alert] = 'Pas d\'adresse mail de destination configurée'
          render :contact
        else
          Notifier.send_contact_mail(@email, to, @message).deliver
          redirect_to({:controller => 'public/index', :action => :sommaire}, {:notice => 'Votre message a été envoyé !'})
        end
      end
    else
      @email = ''
      @message = ''
      render :contact
    end
  end

end