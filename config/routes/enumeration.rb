# frozen_string_literal: true

ApiScheduler::Application.routes.draw do
  namespace :enumerations do
    resources :integration_types, only: %i[index show]
    resources :schedule_situations, only: %i[index show]
  end
end
