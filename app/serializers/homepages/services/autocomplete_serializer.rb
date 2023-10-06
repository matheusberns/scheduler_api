# frozen_string_literal: true

module Homepages::Services
  class AutocompleteSerializer < BaseSerializer
    attributes :uuid,
               :code,
               :name,
               :campos_personalizados
  end
end
