Rails.application.routes.draw do
  # Landing Page
  root :to => "site/home#index"

  devise_for :user, :path => '', :path_names => {:sign_in => 'login', :sign_out => 'logout'}

  namespace :admin do 
    resources :dashboard
    resources :students
    resources :employees
    resources :tuition_fee_module
    resources :payments do
      collection do
        get 'discount_checker'
      end
    end

    # CRUDS
    resources :school_years
    resources :year_levels
    resources :discounts
    resources :school_uniforms
    resources :pe_uniforms
    resources :school_supplies

    namespace :tuition_fee_module do 
      resources :cash_basis_fees
      resources :installment_basis_fees
    end
  end
  
end
