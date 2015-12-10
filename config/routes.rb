Rails.application.routes.draw do

=begin 

  #in this line, we want to redirect the user to the controller:Pages and view:Home if he writes /home. Meaning we can create any path and redirect it to somewhere
  get '/home', to: 'pages#home'
  #we need to make the main URL to be the home page by defaul. So we will write command
  get "/recipes", to: "recipes#index"
  #We use "AS:" when we want to change how the URL will show to the user. You can check the Prefix using "RAKE ROUTES" command.
  get "/recipes/new", to: "recipes#new", as: "new_recipe"
  #We use "POST" when we create a controller & action for creating data 
  post "/recipes/create", to: "recipes#create"
  get "/recipes/:id/edit", to: "recipes#edit", as: "edit_recipe"
  #We use "PATCH" to handle the submission of a form
  patch "*recipes/:id", to: "recipes#update"
  get "recipes/:id", to: "recipes#show", as: "recipe"
  #We use "DELETE" to delete items
  delete "/recipes/:id", to: "recipes#destroy"
  
=end

  root 'pages#home'
  #All the above routes of recipes can be created using one line like this (RESOURCES :RECIPES)
  #Now we'll build a new route for "LIKES" in recipes. so we'll change the "RESOURCES" structure using "DO & MEMBER"
  resources :recipes do
    member do
      post 'like'
    end
  end
  
  #We need to provide custome "NEW" route for chefs because it is "REGISTER" not "NEW"
  resources :chefs, except: [:new]
  get '/register', to: 'chefs#new'
  
  #Here we'll define routes for log in/log out. Our controller's name will be "LOGINS"
  #We need a route for crating a new session
  get '/login', to: 'logins#new'
  #Then we need a post route to post the new, created session to it
  post '/login', to: 'logins#create'
  #And then we need a third route for destroying the session
  get '/logout', to: 'logins#destroy'
end
