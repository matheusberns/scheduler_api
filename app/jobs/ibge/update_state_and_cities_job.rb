# frozen_string_literal: true

module Ibge
  class UpdateStateAndCitiesJob < ApplicationJob
    queue_as :update_state_and_cities_job

    def self.scheduled(_queue, _klass, *_args)
      UpdateStateAndCitiesJob.update_state_and_cities
    end

    def perform
      UpdateStateAndCitiesJob.update_state_and_cities
    end

    def self.update_state_and_cities
      states_consult = ::Ibge::State.new
      states_consult.import if states_consult.find

      ::Region::State.list.activated.each do |state|
        cities_consult = ::Ibge::City.new(state: state)
        cities_consult.import if cities_consult.find
      end

      ::Vetorh::UpdateDistrictsJob.perform_later
    end
  end
end
