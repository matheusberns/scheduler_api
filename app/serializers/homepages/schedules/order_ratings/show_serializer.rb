# frozen_string_literal: true

module Homepages::Schedules::OrderRatings
  class ShowSerializer < BaseSerializer
    attributes :rating,
               :description,
               :rating_type
  end
end
