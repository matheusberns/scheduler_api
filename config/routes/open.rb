# frozen_string_literal: true

ApiScheduler::Application.routes.draw do
  namespace :open do
    match 'open/accounts' => 'homepages/accounts#show', via: :get
  end
end
