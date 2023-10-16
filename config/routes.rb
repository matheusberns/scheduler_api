# frozen_string_literal: true

Rails.application.routes.draw do
  # Load others routes files
  draw(:account_admin)
  draw(:admin)
  draw(:current_user)
  draw(:enumeration)
  draw(:integration)
  draw(:open)

  root :to => 'home#index'

  # Regions
  resources :states, controller: 'regions/states', only: :index
  resources :cities, controller: 'regions/cities', only: :index

  # Cable
  mount ActionCable.server => '/cable'

  # Devise overrides
  mount_devise_token_auth_for 'User', at: 'auth', controllers: {
    token_validations: 'overrides/token_validations',
    sessions: 'overrides/sessions',
    passwords: 'overrides/passwords'
  }

  scope module: :homepages do
    match 'list_accounts' => 'accounts#show', via: :get

    resources :headquarters, only: %i[index show], controller: 'headquarters'

    resources :news, except: %i[new edit], controller: 'news'
    match 'news/:id/recover' => 'news#recover', via: %i[patch put]

    resources :schedules, except: %i[new edit], controller: 'schedules' do
      resources :schedule_products, only: %i[index show], controller: 'schedules/schedule_products'
      resources :schedule_services, except: %i[new edit], controller: 'schedules/schedule_services'
    end

    resources :payment_conditions, only: %i[index show], controller: 'payment_conditions'

    resources :products, only: %i[index show update], controller: 'products'

    resources :product_derivations, only: %i[index show], controller: 'product_derivations'

    resources :representatives, only: %i[index show], controller: 'representatives'

    resources :services, except: %i[new edit], controller: 'services'
    match 'services/:id/recover' => 'services#recover', via: %i[put patch]
    match 'services/:id/attachments/:attachment_id/delete' => 'services#attachment_delete', via: %i[put patch]

    resources :transporters, only: %i[index show], controller: 'transporters'
  end
end
