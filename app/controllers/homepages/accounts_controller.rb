# frozen_string_literal: true

module Homepages
  class AccountsController < ::ApplicationController
    before_action :set_account, only: %i[show]

    def show
      render_show_json(@account, Homepages::Accounts::ShowSerializer, 'account')
    end

    private

    def set_account
      @account = Account.find_by(base_url: params[:subdominio])
    end
  end
end
