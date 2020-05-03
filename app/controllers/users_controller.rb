class UsersController < ApplicationController
  before_action :set_user, only: [:edit, :update, :destroy]
  before_action :set_users, only: [:create, :update]
  helper_method :sort_column, :sort_direction

  def index
    @user = User.new 
    if params[:query].present?
      if Rails.env.development?
        @users = User.where("name LIKE ? or email LIKE ?", "%#{params[:query]}%", "%#{params[:query]}%").order("#{sort_column} #{sort_direction}").paginate(page: params[:page])
      else
        @users = User.where("name ILIKE ? or email ILIKE ?", "%#{params[:query]}%", "%#{params[:query]}%").order("#{sort_column} #{sort_direction}").paginate(page: params[:page])
      end
    else
      set_users
    end
  end

  def new
  end

  def create
    @user = User.create(user_params)
    if @user.save
      flash[:success] = "New User: #{@user.name} was successfully added."
      redirect_back fallback_location: root_url
    else
      flash[:danger] = "Name/Email missing or Email already used. New User was not added."
      redirect_back fallback_location: root_url
    end
  end

  def edit
  end

  def update
    if @user.update(user_params)
      flash[:success] = "User #{@user.name} was successfully updated."
      redirect_back fallback_location: root_url
    else
      render :edit
    end
  end

  def destroy
    gone_user = @user
    @user.destroy
    flash[:danger] = "User #{gone_user.name} was deleted."
    redirect_back fallback_location: root_url
  end

  private

    def user_params
      params.require(:user).permit(:name, :email, :title, :phone, :status)
    end

    def set_user
      @user = User.find(params[:id])
    end

    def set_users
      @users = User.order("#{sort_column} #{sort_direction}").paginate(page: params[:page])
    end

    def sort_column
      User.column_names.include?(params[:sort]) ? params[:sort] : "updated_at"
    end

    def sort_direction
      %w[asc desc].include?(params[:direction]) ? params[:direction] : "desc"
    end

end
