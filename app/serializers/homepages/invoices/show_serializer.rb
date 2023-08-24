# frozen_string_literal: true

module Homepages::Invoices
  class ShowSerializer < BaseSerializer
    attributes :invoice_number,
               :total_value,
               :emission_date,
               :invoice_type,
               :purchase_order,
               :headquarter,
               :status,
               :uuid

    def invoice_number
      object.service_number || object.invoice_number
    end

    def invoice_type
      return unless object.invoice_type

      {
        id: object.invoice_type,
        name: object.invoice_type_humanize
      }
    end

    def status
      return unless object.status

      {
        id: object.status,
        name: object.status_humanize
      }
    end

    def headquarter
      {
        id: object.headquarter_id,
        name: object.headquarter_name
      }
    end
  end
end
