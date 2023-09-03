# frozen_string_literal: true

module AccountAdmins
  class ServicesController < ::ApiController
    before_action :set_service, only: %i[show update destroy images]

    def index
      @services = @account.services.list

      @services = apply_filters(@services, :active_boolean,
                                :by_name,
                                :by_code)

      render_index_json(@services, Services::IndexSerializer, 'services')
    end

    def autocomplete
      @services = @account.services.autocomplete

      @services = apply_filters(@services, :active_boolean, :by_search)

      render_index_json(@services, Services::AutocompleteSerializer, 'services')
    end

    def show
      render_show_json(@service, Services::ShowSerializer, 'service')
    end

    def create
      @service = @account.services.new(service_create_params)

      if @service.save
        render_show_json(@service, Services::ShowSerializer, 'service', 201)
      else
        render_errors_json(@service.errors.messages)
      end
    end

    def update
      if @service.update(service_update_params)
        render_show_json(@service, Services::ShowSerializer, 'service')
      else
        render_errors_json(@service.errors.messages)
      end
    end

    def destroy
      if @service.destroy
        render_success_json
      else
        render_errors_json(@service.errors.messages)
      end
    end

    def recover
      @service = @account.services.list.active(false).find(params[:id])

      if @service.recover
        render_show_json(@service, Services::ShowSerializer, 'service')
      else
        render_errors_json(@service.errors.messages)
      end
    end

    def images
      if @service.update(images_params)
        render_show_json(@service, Services::ShowSerializer, 'service')
      else
        render_errors_json(@service.errors.messages)
      end
    end

    private

    def set_service
      @service = @account.services.activated.list.find(params[:id])
    end

    def service_create_params
      service_params.merge(created_by_id: @current_user.id)
    end

    def service_update_params
      service_params.merge(updated_by_id: @current_user.id)
    end

    def images_params
      params
        .require(:service)
        .permit(:image)
        .transform_values do |value|
        value == 'null' ? nil : value
      end
        .merge(skip_validation: true)
    end

    def service_params
      params
        .require(:service)
        .permit(:name,
                :code,
                :value,
                :duration)
    end
  end
end
