class Admin::WelcomeController < Admin::BaseController

  before_filter :authenticate_admin, only: [:dashboard]

  before_filter :authenticate_no_admin, only: [:index, :sign_up_]

  def index

  end

  def dashboard

  end

  def register

  end

  def log_in
    if sign_in_admin
      redirect_to action: :dashboard
    else
      flash[:error] = 'Email/Password combination wrong, contact super admin.'
      render action: :index
    end
  end

  def sign_up_
    @user = Admin.new(user_params)
    if @user.save
      sign_in(@user)
      redirect_to action: :dashboard
    else
      flash[:error] = "#{@user.errors.full_messages.first}"
      render action: :register
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