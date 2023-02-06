# frozen_string_literal: true

ApiScheduler::Application.routes.draw do
  scope module: :integrations do
    match 'integration/headquarters' => 'headquarters#create', via: :post, controller: 'integrations/headquarters'
  end
end
