Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  get '/csrf-token', to: 'application#get_csrf_token'

  resources :categories
  resources :merchants
  resources :transactions do
    collection do
      get :needs_review
    end

    member do
      patch :mark_as_reviewed
      patch :update_category
    end
  end
end
