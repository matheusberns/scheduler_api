# frozen_string_literal: true

module Homepages
  class AccountsController < ::ApplicationController
    before_action :set_account, only: %i[show]

    def show
      render_show_json(@account, Accounts::ShowSerializer, 'account')
    end

    private

    def set_account
      @account = Account.find_by(base_url: params[:subdominio])
    end

    def render_show_json(object, serializer, return_name, status = nil, custom_params = nil)
      object_all_fields = object.class.show.find(object.id)
      status ||= 200
      fields = params[:attributes].split(',') if params[:attributes].present?

      return_name = return_name.camelize(:lower) if params[:key_transform_camel_lower]

      render json: {
        return_name => ActiveModelSerializers::SerializableResource.new(object_all_fields, {
          serializer: serializer,
          params: custom_params,
          fields: fields,
          key_transform: (params[:key_transform_camel_lower] ? 'camel_lower' : nil)
        }).as_json
      }, status: status
    end
  end
end
