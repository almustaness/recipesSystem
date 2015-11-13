Rails.application.routes.draw do
  #in this line, we want to redirect the user to the controller:Pages and view:Home if he writes /home. Meaning we can create any path and redirect it to somewhere
  get '/home', to: 'pages#home'
  #we need to make the main URL to be the home page by defaul. So we will write command
  root 'pages#home'
end
