  # frozen_string_literal: true

ApiScheduler::Application.routes.draw do
  # root :to => 'home#index'

  scope module: :account_admins do
    match 'headquarters/autocomplete' => 'headquarters#autocomplete', via: :get
    resources :headquarters, only: %i[index show create update destroy]

    resources :services, only: %i[index show create update destroy]
    match 'services/autocomplete' => 'services#autocomplete', via: :get
    match 'services/:id/recover' => 'services#recover', via: %i[put patch]

    resources :products, only: %i[index show create update destroy]
    match 'products/autocomplete' => 'products#autocomplete', via: :get
    match 'products/:id/recover' => 'products#recover', via: %i[put patch]

    match 'current_account/show' => 'current_account/accounts#show', via: :get
    match 'current_account/update' => 'current_account/accounts#update', via: %i[put patch]
    match 'current_account/images' => 'current_account/accounts#images', via: %i[put patch]
    match 'current_account/tools' => 'current_account/tools#index', via: :get

    match 'users/autocomplete' => 'users#autocomplete', via: :get
    resources :users, only: %i[index show create update destroy]
    match 'users/:id/recover' => 'users#recover', via: %i[put patch]
    match 'users/:id/images' => 'users#images', via: %i[put patch]

    match 'user_admins/autocomplete' => 'users#autocomplete', via: :get
    resources :user_admins, only: %i[index show create update destroy]
    match 'user_admins/:id/recover' => 'users#recover', via: %i[put patch]
    match 'user_admins/:id/images' => 'users#images', via: %i[put patch]
  end
end
