# frozen_string_literal: true

module AccountAdmins
  class SchedulesController < ::ApiController
    before_action :set_schedule, only: %i[show update destroy attachment_delete]

    def index
      @schedules = @account.schedules.list

      @schedules = apply_filters(@schedules, :active_boolean,
                                 :by_schedule_id,
                                 :by_date_date_range)

      render_index_json(@schedules, Schedules::IndexSerializer, 'schedules')
    end

    def show
      render_show_json(@schedule, Schedules::ShowSerializer, 'schedule')
    end

    def create
      @schedule = @current_user.headquarter.schedules.new(schedule_create_params)

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
      @schedule = @current_user.schedules.list.active(false).find(params[:id])

      if @schedule.recover
        render_show_json(@schedule, Schedules::ShowSerializer, 'schedule')
      else
        render_errors_json(@schedule.errors.messages)
      end
    end

    private

    def set_schedule
      @schedule = @current_user.headquarter.schedules.find(params[:id])
    end

    def schedule_create_params
      schedule_params.merge(created_by_id: @current_user.id, account_id: @current_user.account_id, date: Time.now)
    end

    def schedule_update_params
      schedule_params.merge(updated_by_id: @current_user.id)
    end

    def schedule_params
      params
        .require(:schedule)
        .permit(:total,
                :discount,
                :situation,
                :customerId,
                :scheduledDate,
                :headquarterId,
                :professionalId,
                :camposPersonalizados,
                services: %i[id price duration],
                products: %i[id price])
        .deep_transform_keys!(&:underscore)
    end
  end
end
