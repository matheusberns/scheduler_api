# frozen_string_literal: true

module AccountAdmins::Services
  class IndexSerializer < BaseSerializer
    attributes :uuid,
               :suggested_price,
               :code,
               :name,
               :description,
               :campos_personalizados
  end
end
