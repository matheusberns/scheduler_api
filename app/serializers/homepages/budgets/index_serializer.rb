# frozen_string_literal: true

module Homepages::Budgets
  class IndexSerializer < BaseSerializer
    attributes :sequence,
               :purchase_order,
               :synchronized,
               :status,
               :representative,
               :headquarter,
               :uuid

    def purchase_order
      object.purchase_order.to_i
    end

    def headquarter
      return unless object.headquarter_id

      {
        id: object.headquarter_id,
        name: object.headquarter_name
      }
    end

    def representative
      return unless object.headquarter.representative_id

      {
        name: object.representative_name
      }
    end

    def status
      return unless object.status

      {
        id: object.status,
        name: object.status_humanize
      }
    end
  end
end
