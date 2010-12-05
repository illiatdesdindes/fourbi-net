Fourbi::Application.routes.draw do
  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
  #   resources :products do
  #     member do
  #       get :short
  #       post :toggle
  #     end
  #
  #     collection do
  #       get :sold
  #     end
  #   end

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get :recent, :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  # root :to => "welcome#index"

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id(.:format)))'

  match 'admin' => 'admin/index#index'

  match 'admin/articles' => 'admin/articles#index'
  match 'admin/articles/new/:id' => 'admin/articles#new'
  match 'admin/articles/delete/:id' => 'admin/articles#delete'
  match 'admin/articles/edit/:id' => 'admin/articles#edit'
  match 'admin/articles/:id' => 'admin/articles#show'
  match 'admin/articles/add_vue/:id' => 'admin/articles#add_vue'
  match 'admin/articles/remove_vue/:id' => 'admin/articles#remove_vue'

  match 'admin/boutiques' => 'admin/boutiques#index'
  match 'admin/boutiques/new' => 'admin/boutiques#new'
  match 'admin/boutiques/edit/:id' => 'admin/boutiques#edit'
  match 'admin/boutiques/reorder/:id' => 'admin/boutiques#reorder'
  match 'admin/boutiques/:id' => 'admin/boutiques#show'

  match 'admin/series' => 'admin/series#index'
  match 'admin/series/new/:id' => 'admin/series#new'
  match 'admin/series/edit/:id' => 'admin/series#edit'
  match 'admin/series/reorder/:id' => 'admin/series#reorder'
  match 'admin/series/:id' => 'admin/series#show'

  match 'admin/clients' => 'admin/clients#index'
  match 'admin/clients/cheque_recu/:id' => 'admin/clients#cheque_recu'
  match 'admin/clients/mail_envoi/:id' => 'admin/clients#mail_envoi'
  match 'admin/clients/new' => 'admin/clients#new'
  match 'admin/clients/edit/:id' => 'admin/clients#edit'
  match 'admin/clients/article/:id' => 'admin/clients#article'
  match 'admin/clients/attente_envoi' => 'admin/clients#attente_envoi'
  match 'admin/clients/attente_paiement' => 'admin/clients#attente_paiement'
  match 'admin/clients/search' => 'admin/clients#search'
  match 'admin/clients/show' => 'admin/clients#show'

  match 'admin/utilisateurs' => 'admin/utilisateurs#index'
  match 'admin/utilisateurs/new' => 'admin/utilisateurs#new'
  match 'admin/utilisateurs/edit/:id' => 'admin/utilisateurs#edit'
  match 'admin/utilisateurs/:id' => 'admin/utilisateurs#show'

  match 'admin/configuration' => 'admin/configuration#index'

  match 'admin/logout' => 'admin/sessions#logout'
  match 'admin/sessions' => 'admin/sessions#index'
  match 'admin/init' => 'admin/sessions#init'


  match 'boutique_desordre' => 'public/desordre#boutique'
  match 'article_desordre/:id' => 'public/desordre#article'
  match 'zoom_image_desordre/:id' => 'public/desordre#zoom_article'
  match 'zoom_vue_desordre/:id' => 'public/desordre#zoom_vue'

  match 'boutique_terrier' => 'public/terrier#boutique'
  match 'article_terrier/:id' => 'public/terrier#article'
  match 'zoom_image_terrier/:id' => 'public/terrier#zoom_article'
  match 'zoom_vue_terrier/:id' => 'public/terrier#zoom_vue'

  match 'panier' => 'public/commande#panier'
  match 'coordonnees' => 'public/commande#coordonnees'
  match 'validation' => 'public/commande#validation'
  match 'bon_de_commande' => 'public/commande#bon_de_commande'

  match 'paiement_echec' => 'public/retour#paiement_echec'
  match 'paiement_succes' => 'public/retour#paiement_succes'
  match 'vider_session' => 'public/retour#vider_session'
  match 'rappel' => 'public/retour#rappel'

  match 'contact/desordre' => 'public/contact#desordre'
  match 'contact/terrier' => 'public/contact#terrier'
  match 'contact' => 'public/contact#index'

  match 'cgv' => 'public/index#cgv'
  match 'aide' => 'public/index#aide'

  root :to => 'public/index#sommaire'

end
