# frozen_string_literal: true

module Homepages::Billings
  class IndexSerializer < BaseSerializer
    attributes :billing,
               :due_date,
               :open_days,
               :amount,
               :order,
               :status,
               :emission_date,
               :invoice_number,
               :order_number,
               :uuid,
               :billet,
               :headquarter

    def open_days
      return unless object.due_date
      return if [::BillingStatusEnum::PAID, ::BillingStatusEnum::CANCEL].include?(object.status)

      (Date.today - object.due_date.to_date).to_i
    end

    def status
      return unless object.status

      if (Date.today > object.due_date.to_date) && ![::BillingStatusEnum::PAID, ::BillingStatusEnum::CANCEL].include?(object.status)
        enum = ::BillingStatusEnum.to_a.find { |object| object[1] == ::BillingStatusEnum::LATE }

        { id: enum[1], name: enum[0] }
      else
        {
          id: object.status,
          name: object.status_humanize
        }
      end
    end

    def order
      return unless object.order_id

      {
        id: object.order_id,
        order_number: object.order_number
      }
    end

    def billet
      if object.account_billet_file_url_fixed
        {
          url: object.billet_file_name
        }
      else
        return unless object.billet.attached?

        {
          id: object.billet.id,
          url: Rails.application.routes.url_helpers.rails_blob_path(object.billet, only_path: true),
          content_type: object.billet.blob.content_type
        }
      end
    end

    def headquarter
      {
        id: object.headquarter_id,
        name: object.headquarter_name
      }
    end
  end
end
