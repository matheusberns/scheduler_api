# frozen_string_literal: true

class ApiController < ApplicationController
  include ActionController::MimeResponds

  before_action :authenticate_user!

  # Velow concerns
  include UserAccess
  include ApplyFilters
  include Renders
  include Sortable

  def find_permission(permission_codes)
    codes = @current_user.permissions.pluck(:code)

    permission_codes.filter { |code| codes.include?(code) }.any?
  end
end
