# frozen_string_literal: true

module Homepages::Schedules::ScheduleRatings
  class IndexSerializer < BaseSerializer
    attributes :rating,
               :description,
               :rating_type
  end
end
