# frozen_string_literal: true

module AccountAdmins
  class HeadquartersController < ::ApiController
    before_action :set_headquarter, only: :show

    def index
      @headquarters = @current_user.account.headquarters.list

      @headquarters = apply_filters(@headquarters, :by_cpf_cnpj,
                                 :by_name)

      render_index_json(@headquarters, ::Homepages::Headquarters::IndexSerializer, 'headquarters')
    end

    def autocomplete
      @headquarters = @current_user.account.headquarters.autocomplete

      @headquarters = @headquarters.by_id(@headquarter_ids) if @headquarter_ids.any?

      @headquarters = apply_filters(@headquarters, :active_boolean, :by_search)

      render_index_json(@headquarters, ::Homepages::Headquarters::AutocompleteSerializer, 'headquarters')
    end

    def show
      render_show_json(@headquarter, ::Homepages::Headquarters::ShowSerializer, 'headquarter', 200)
    end

    private

    def set_headquarter
      @headquarter = @current_user.account.headquarters.show.find(params[:id])
    end
  end
end
