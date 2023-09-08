# frozen_string_literal: true

module AccountAdmins::Services
  class AutocompleteSerializer < BaseSerializer
    attributes :uuid,
               :code,
               :name,
               :campos_personalizados
  end
end
