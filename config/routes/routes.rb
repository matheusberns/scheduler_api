# frozen_string_literal: true

Rails.application.routes.draw do
  namespace 'api', defaults: { format: :json } do
    match 'accounts/:subdominio' => 'accounts#show', via: :get
  end
end
