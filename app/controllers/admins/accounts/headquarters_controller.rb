# frozen_string_literal: true

module Admins::Accounts
  class HeadquartersController < BaseController
    def index
      @headquarters = @account.headquarters.list

      @headquarters = apply_filters(@headquarters, :active_boolean,
                                 :by_name,
                                 :by_email)

      render_index_json(@headquarters, Headquarters::IndexSerializer, 'headquarters')
    end
  end
end
