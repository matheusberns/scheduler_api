# frozen_string_literal: true

module Homepages
  class SchedulesController < ::ApiController
    before_action :set_headquarter, only: %i[create show update destroy]
    before_action :set_schedule, only: %i[show update destroy]

    def index
      @schedules = @headquarter.schedules.list

      @schedules = apply_filters(@schedules, :active_boolean,
                                 :by_schedule_id,
                                 :by_date_date_range)

      render_index_json(@schedules, Schedules::IndexSerializer, 'schedules')
    end

    def show
      render_show_json(@schedule, Schedules::ShowSerializer, 'schedule')
    end

    def create
      @schedule = @headquarter.schedules.new(schedule_create_params)

      if @schedule.save
        render_show_json(@schedule, Schedules::ShowSerializer, 'schedule', 201)
      else
        render_errors_json(@schedule.errors.messages)
      end
    end

    def update
      if @schedule.update(schedule_update_params)
        add_images if params[:schedule][:attachments]

        render_show_json(@schedule, Schedules::ShowSerializer, 'schedule', 200)
      else
        render_errors_json(@schedule.errors.messages)
      end
    end

    def destroy
      if @schedule.destroy
        render_success_json
      else
        render_errors_json(@schedule.errors.messages)
      end
    end

    def recover
      @schedule = Schedule.list.active(false).find(params[:id])

      if @schedule.recover
        render_show_json(@schedule, Schedules::ShowSerializer, 'schedule')
      else
        render_errors_json(@schedule.errors.messages)
      end
    end

    private

    def set_schedule
      @schedule = @headquarter.schedules.find(params[:id])
    end

    def set_headquarter
      @headquarter = @account.headquarters.find(params[:id])
    end

    def schedule_create_params
      schedule_params.merge(created_by_id: @current_user.id, account_id: @current_user.account_id)
    end

    def schedule_update_params
      schedule_params.merge(updated_by_id: @current_user.id)
    end

    def schedule_params
      params
        .require(:schedule)
        .permit(:scheduled_date,
                :situation,
                :discount,
                :total,
                :customer_id,
                :professional_id,
                :service_ids,
                :product_ids,
                :campos_personalizados)
    end
  end
end
