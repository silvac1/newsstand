class UsersController < ApplicationController
  before_action :require_authenticated_owner, except: [:new, :create]

  def new
    @user = User.new
  end

  def create
  	 @user = User.new(user_params)
		if @user.save
 	 		session[:user_id] = @user.id
  		redirect_to '/'
		 else
 	 	redirect_to '/signup'
		end
	end

  def show
    user
  end

  def edit
    user
  end

  def update
    if user.update(user_params)
      redirect_to user
    else
      render :edit
    end
  end

private

  def user
    @user ||= User.find(params[:id])
  end

	def user_params
		params.require(:user).permit(:first_name, :last_name, :email, :password)
	end

  def require_authenticated_owner
    redirect_to root_url if !current_user || params[:id].to_i != session[:user_id]
  end
end
