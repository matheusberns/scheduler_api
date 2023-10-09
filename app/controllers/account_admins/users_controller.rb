module AccountAdmins
  class UsersController < ::ApiController
    include CheckCurrentPassword
    include PasswordChangeManageTokens
    before_action :validate_permission, except: %i[show autocomplete]
    before_action :validate_current_password, only: :update
    before_action :set_user, only: %i[show update images approve_nickname reprove_nickname
                                      update_salary_advance unlock_user remove_sessions create_facial_id validate_facial_id]

    def index
      @users = @account.users.list.not_account_administrator

      @users = apply_filters(@users, :active_boolean,
                             :by_name,
                             :by_email,
                             :by_cpf,
                             :by_id,
                             :by_phone_extension,
                             :by_license_plate,
                             :by_identification_number,
                             :by_birthday_date_range,
                             :by_department_id,
                             :by_headquarter_id)

      respond_to do |format|
        format.json do
          render_index_json(@users, Users::IndexSerializer, 'users')
        end

        format.xlsx do
          users = sortable(@users)
          file_url = ::Export::UserExcel.new(users).file_url
          render json: { file: file_url }, status: :ok
        end
      end
    end

    def autocomplete
      @users = @account.users.autocomplete

      @users = apply_filters(@users, :active_boolean,
                             :by_search,
                             :by_attendance_category_id,
                             :by_incident_location_id,
                             :by_manager_id,
                             :by_sale_type,
                             :only_managers_boolean,
                             :by_headquarter_id,
                             :by_department_id,
                             :by_manager_id,
                             :by_job_title_id,
                             :by_hide_specific_users,
                             :by_shift_id)

      render_autocomplete(@users, Users::AutocompleteSerializer, 'users')
    end

    def show
      render_show_json(@user, Users::ShowSerializer, 'user', 200)
    end

    def create
      @user = @account.users.new(user_create_params)

      if @user.save
        render_show_json(@user, Users::ShowSerializer, 'user', 201)
      else
        render_errors_json(@user.errors.messages)
      end
    end

    def update
      update_params = @user.identification_number? ? user_update_params : user_update_professional_params

      if @user.update(update_params)
        manage_current_tokens
        render_show_json(@user, Users::ShowSerializer, 'user')
      else
        render_errors_json(@user.errors.messages)
      end
    end

    def destroy
      verify_if_is_current_user_being_destroyed
      @user = @account.users.list.not_account_administrator.find(params[:id])

      if @user.destroy
        render_success_json
      else
        render_errors_json(@user.errors.messages)
      end
    end

    def recover
      @user = @account.users.list.not_account_administrator.active(false).find(params[:id])

      if @user.recover
        render_show_json(@user, Users::ShowSerializer, 'user')
      else
        render_errors_json(@user.errors.messages)
      end
    end

    def images
      if @user.update(images_params)
        render_show_json(@user, Users::ShowSerializer, 'user')
      else
        render_errors_json(@user.errors.messages)
      end
    end

    private

    def validate_permission
      render_error_json(status: 405) unless find_permission([::PermissionCodeEnum::USER_MANAGE])
    end

    def set_user
      @user = @account.users.activated.list.find(params[:id])
    end

    def user_create_params
      create_params.merge(created_by_id: @current_user.id, profile_type: ProfileTypeEnum::PROFESSIONAL)
    end

    def user_update_params
      user_params.merge(updated_by_id: @current_user.id, skip_photo_validation: true)
    end

    def images_params
      params
        .require(:user)
        .permit(:photo,
                :background_profile_image)
        .transform_values do |value|
        value == 'null' ? nil : value
      end
    end

    def user_params
      params
        .require(:user)
        .permit(:phone,
                :address,
                :zipcode,
                :city_id,
                :nickname,
                :password,
                :state_id,
                :cellphone,
                :occupation,
                :timeout_in,
                :district_id,
                :address_number,
                :personal_email,
                :phone_extension,
                :address_complement,
                :dont_show_birthday,
                :force_change_password,
                :password_confirmation)
    end

    def create_params
      params
        .require(:user)
        .permit(:cpf,
                :name,
                :email,
                :password,
                :headquarter_id,
                :password_confirmation)
    end
  end
end
