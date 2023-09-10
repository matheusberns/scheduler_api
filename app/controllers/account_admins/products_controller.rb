# frozen_string_literal: true

module AccountAdmins
  class ProductsController < ::ApiController
    before_action :set_product, only: %i[show update destroy images]

    def index
      @products = @account.products.list

      @products = apply_filters(@products, :active_boolean,
                                :by_name,
                                :by_code)

      render_index_json(@products, Products::IndexSerializer, 'products')
    end

    def autocomplete
      @products = @account.products.autocomplete

      @products = apply_filters(@products, :active_boolean, :by_search)

      render_index_json(@products, Products::AutocompleteSerializer, 'products')
    end

    def show
      render_show_json(@product, Products::ShowSerializer, 'product')
    end

    def create
      @product = @account.products.new(product_create_params)

      if @product.save
        render_show_json(@product, Products::ShowSerializer, 'product', 201)
      else
        render_errors_json(@product.errors.messages)
      end
    end

    def update
      if @product.update(product_update_params)
        render_show_json(@product, Products::ShowSerializer, 'product')
      else
        render_errors_json(@product.errors.messages)
      end
    end

    def destroy
      if @product.destroy
        render_success_json
      else
        render_errors_json(@product.errors.messages)
      end
    end

    def recover
      @product = @account.products.list.active(false).find(params[:id])

      if @product.recover
        render_show_json(@product, Products::ShowSerializer, 'product')
      else
        render_errors_json(@product.errors.messages)
      end
    end

    def images
      if @product.update(images_params)
        render_show_json(@product, Products::ShowSerializer, 'product')
      else
        render_errors_json(@product.errors.messages)
      end
    end

    private

    def set_product
      @product = @account.products.activated.list.find(params[:id])
    end

    def product_create_params
      product_params.merge(created_by_id: @current_user.id)
    end

    def product_update_params
      product_params.merge(updated_by_id: @current_user.id)
    end

    def images_params
      params
        .require(:product)
        .permit(:image)
        .transform_values do |value|
        value == 'null' ? nil : value
      end
        .merge(skip_validation: true)
    end

    def product_params
      params
        .require(:product)
        .permit(:name,
                :code,
                :description,
                :suggestedPrice)
        .deep_transform_keys!(&:underscore)
    end
  end
end
