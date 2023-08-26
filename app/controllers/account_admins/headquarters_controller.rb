# frozen_string_literal: true

module AccountAdmins
  class HeadquartersController < ::ApiController
    before_action :set_headquarter, only: %i[show update destroy images]

    def index
      @headquarters = @account.headquarters.list

      @headquarters = apply_filters(@headquarters, :active_boolean,
                                    :by_name,
                                    :by_nickname,
                                    :by_social_reason,
                                    :by_cnpj)

      render_index_json(@headquarters, Headquarters::IndexSerializer, 'headquarters')
    end

    def autocomplete
      @headquarters = @account.headquarters.autocomplete

      @headquarters = apply_filters(@headquarters, :active_boolean, :by_search)

      render_index_json(@headquarters, Headquarters::AutocompleteSerializer, 'headquarters')
    end

    def show
      render_show_json(@headquarter, Headquarters::ShowSerializer, 'headquarter')
    end

    def create
      @headquarter = @account.headquarters.new(headquarter_create_params)

      if @headquarter.save
        render_show_json(@headquarter, Headquarters::ShowSerializer, 'headquarter', 201)
      else
        render_errors_json(@headquarter.errors.messages)
      end
    end

    def update
      if @headquarter.update(headquarter_update_params)
        render_show_json(@headquarter, Headquarters::ShowSerializer, 'headquarter')
      else
        render_errors_json(@headquarter.errors.messages)
      end
    end

    def destroy
      if @headquarter.destroy
        render_success_json
      else
        render_errors_json(@headquarter.errors.messages)
      end
    end

    def recover
      @headquarter = @account.headquarters.list.active(false).find(params[:id])

      if @headquarter.recover
        render_show_json(@headquarter, Headquarters::ShowSerializer, 'headquarter')
      else
        render_errors_json(@headquarter.errors.messages)
      end
    end

    def images
      if @headquarter.update(images_params)
        render_show_json(@headquarter, Headquarters::ShowSerializer, 'headquarter')
      else
        render_errors_json(@headquarter.errors.messages)
      end
    end

    def consult_cnpj
      @consult = ::Consults::Cnpj.new(cnpj: params[:cnpj])
      @consult.get

      render_success_json(body: @consult.headquarter_object)
    end

    private

    def set_headquarter
      @headquarter = @account.headquarters.activated.list.find(params[:id])
    end

    def headquarter_create_params
      headquarter_params.merge(created_by_id: @current_user.id)
    end

    def headquarter_update_params
      headquarter_params.merge(updated_by_id: @current_user.id)
    end

    def images_params
      params
        .require(:headquarter)
        .permit(:logo)
        .transform_values do |value|
        value == 'null' ? nil : value
      end
        .merge(skip_validation: true)
    end

    def headquarter_params
      params
        .require(:headquarter)
        .permit(:name,
                :social_reason,
                :nickname,
                :cnpj,
                :zipcode,
                :address,
                :address_number,
                :address_complement,
                :email,
                :phone,
                :secondary_phone,
                :state_id,
                :city_id)
    end
  end
end
