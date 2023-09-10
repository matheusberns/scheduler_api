# frozen_string_literal: true

module Enumerations
  class ScheduleSituationsController < ::ApiController
    before_action :set_object, only: :show

    def index
      render_enum_index_json(::ScheduleSituationEnum.to_a, 'schedule_situations')
    end

    def show
      render_enum_show_json(@object, 'schedule_situation')
    end

    private

    def set_object
      @object = ::ScheduleSituationEnum.to_a.find { |object| object[1].to_s == params[:id] }

      raise ::ActiveRecord::RecordNotFound if @object.nil?
    end
  end
end
