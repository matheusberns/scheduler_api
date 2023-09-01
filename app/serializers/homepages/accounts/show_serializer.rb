# frozen_string_literal: true

module Homepages::Accounts
  class ShowSerializer < BaseSerializer
    attributes :name,
               :base_url,
               :primary_color,
               :secondary_color,
               :campos_personalizados,
               :uuid
  end
end
