# frozen_string_literal: true

module Homepages::Schedules
  class IndexSerializer < BaseSerializer
    attributes :scheduled_date,
               :situation,
               :discount,
               :total,
               :customer_id,
               :professional_id,
               :headquarter_id,
               :campos_personalizados,
               :services,
               :products

    def headquarter
      {
        id: object.headquarter_id,
        name: object.headquarter_name
      }
    end

    def situation
      return unless object.situation

      {
        id: object.situation,
        name: object.situation_humanize
      }
    end

    def services
      object.schedule_services.map do |schedule_service|

        {
          id: schedule_service.id,
          name: schedule_service.service.name,
          price: schedule_service.price,
          duration: schedule_service.duration
        }
      end
    end

    def products
      object.schedule_products.map do |schedule_product|

        {
          id: schedule_product.id,
          name: schedule_product.product.name,
          price: schedule_product.price
        }
      end
    end

    def total
      (object.schedule_products.pluck(:price).sum.to_f + object.schedule_services.pluck(:price).sum.to_f) - object.discount.to_f
    end
  end
end
