# frozen_string_literal: true

module AccountAdmins::Headquarters
  class AutocompleteSerializer < ActiveModel::Serializer
    attributes :id, :name
  end
end
