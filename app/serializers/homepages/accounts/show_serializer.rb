# frozen_string_literal: true

module Homepages::Accounts
  class ShowSerializer < BaseSerializer
    attributes :name,
               :subdomain,
               :primary_color,
               :secondary_color,
               :campos_personalizados,
               :uuid
  end
end
