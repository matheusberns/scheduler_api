# frozen_string_literal: true

module Homepages::Headquarters
  class BaseController < ::ApiController
    before_action :set_headquarter

    private

    def set_headquarter
      @headquarter = @current_user.account.headquarters.activated.find(params[:headquarter_id]) if params[:headquarter_id]
    end
  end
end
