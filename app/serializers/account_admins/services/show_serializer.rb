# frozen_string_literal: true

module AccountAdmins::Services
  class ShowSerializer < BaseSerializer
    attributes :uuid,
               :suggested_price,
               :code,
               :name,
               :description,
               :default_duration,
               :campos_personalizados
  end
end
