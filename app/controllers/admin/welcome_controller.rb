class Admin::WelcomeController < Admin::BaseController

  before_filter :authenticate_admin, only: [:dashboard]

  def index

  end

  def dashboard

  end

  def register

  end

  def log_in
    if sign_in_admin
      render status: :ok
    else
      render status: :unprocessable_entity, json: { errors: 'Email/Password combination wrong' }
    end
  end

  def sign_up_
    @user = Admin.new(user_params)
    if @user.save
      sign_in(@user)
      render status: :ok, json: { success: 'Successfully registred' }
    else
      render status: :unprocessable_entity, json: { errors: @user.errors.full_messages.first }
    end
  end

  private

  def sign_in_admin
    email = params[:email]
    password = params[:password]
    return false unless email.present? or password.present?
    admin = Admin.where(email: email).first
    return false unless admin.present?
    if admin.valid_password?(password)
      flash[:success] = "Signed in as #{admin.name}"
      sign_in(admin)
    end
  end

  def user_params
    params.require(:admin).permit(
        :name,
        :email,
        :password,
    )
  end

end