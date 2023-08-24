# frozen_string_literal: true

module Homepages::Headquarter
  class AutocompleteSerializer < BaseSerializer
    attributes :name,
               :code
  end
end
