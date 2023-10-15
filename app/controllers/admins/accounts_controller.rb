module Admins
  class AccountsController < ::ApiController
    before_action :set_account, only: %i[show
                                         update
                                         images
                                         send_mail]

    def index
      @accounts = ::Account.list

      @accounts = apply_filters(@accounts, :active_boolean,
                                :by_name,
                                :by_uuid)

      render_index_json(@accounts, Accounts::IndexSerializer, 'accounts')
    end

    def autocomplete
      @accounts = ::Account.autocomplete

      @accounts = apply_filters(@accounts, :active_boolean, :by_search)

      render_autocomplete(@accounts, Accounts::AutocompleteSerializer, 'accounts')
    end

    def show
      render_show_json(@account, Accounts::ShowSerializer, 'account')
    end

    def create
      @account = ::Account.new(account_create_params)

      if @account.save
        render_show_json(@account, Accounts::ShowSerializer, 'account', 201)
      else
        render_errors_json(@account.errors.messages)
      end
    end

    def update
      if @account.update(account_update_params)
        render_show_json(@account, Accounts::ShowSerializer, 'account')
      else
        render_errors_json(@account.errors.messages)
      end
    end

    def destroy
      @account = ::Account.list.find(params[:id])

      if @account.destroy
        render_success_json
      else
        render_errors_json(@account.errors.messages)
      end
    end

    def recover
      @account = ::Account.list.active(false).find(params[:id])

      if @account.recover
        render_show_json(@account, Accounts::ShowSerializer, 'account')
      else
        render_errors_json(@account.errors.messages)
      end
    end

    def images
      if @account.update(images_params)
        render_show_json(@account, Accounts::ShowSerializer, 'account')
      else
        render_errors_json(@account.errors.messages)
      end
    end

    def send_mail
      if @account.send_mail(received_email: params[:received_email])
        render_success_json
      else
        render_errors_json(@account.errors.messages)
      end
    end

    private

    def set_account
      @account = ::Account.activated.list.find(params[:id])
    end

    def account_create_params
      account_params.merge(created_by_id: @current_user.id)
    end

    def account_update_params
      account_params.merge(updated_by_id: @current_user.id)
    end

    def images_params
      params
        .require(:account)
        .permit(:logo,
                :logo_login,
                :toolbar_background,
                :users_background_default)
        .transform_values do |value|
        value == 'null' ? nil : value
      end
    end

    def account_params
      params
        .require(:account)
        .each_pair { |key, value| format_form_data_params(key, value) }
        .permit(
          :uuid,
          :smtp_user,
          :smtp_password,
          :smtp_host,
          :smtp_email,
          :smtp_ssl,
          :users_timeout,
          :mandatory_comment,
          :timeout_in,
          :timeout_in_to_all_users
        )
    end

    def format_form_data_params(key, value)
      symbol_key = key.to_sym

      return unless format_flag_params?(symbol_key)

      params[:account][symbol_key] = false if ['null', nil].include?(value)
    end

    def format_flag_params?(symbol_key)
      %i[users_timeout
         is_active_directory
         imap_ssl
         force_change_password
         mandatory_comment
         smtp_ssl
         blocked_chat
         user_can_reset_pin
         active_directory_can_change_password
         logout_by_tab_closed
         apply_same_background_image_to_users
         need_available_emergency_car
         active_directory_allow_blocked_user
         show_birthdays_of_month
         import_user_hiring_historic
         create_department_on_import_user
         valid_professional_email
         hide_employee_birthday
         can_force_record
         organizational_chart_enabled
         block_user_background_photo_change
         block_user_photo_change].include?(symbol_key)
    end
  end
end
