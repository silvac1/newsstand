class UsersController < ApplicationController
  before_action :require_authenticated_owner

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
    @user = User.find(params[:id])
  end

private

	def user_params
		params.require(:user).permit(:first_name, :last_name, :email, :password)
	end

  def require_authenticated_owner
    redirect_to root_url if !current_user || params[:id].to_i != session[:user_id]
  end
end
