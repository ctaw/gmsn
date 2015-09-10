Rails.application.routes.draw do
  # Landing Page
  root :to => "site/home#index"

  devise_for :user, :path => '', :path_names => {:sign_in => 'login', :sign_out => 'logout'}

  namespace :admin do 
    resources :dashboard
    resources :students
  end
end
