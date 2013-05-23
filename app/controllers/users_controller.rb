class UsersController < ApplicationController

before_filter :signed_in_user, only: [:edit, :update, :index]
before_filter :correct_user,   only: [:edit, :update]
before_filter :admin_user, 	   only: :destroy

	def edit
		#@user = User.find(params[:id])
	end

	def update
		#@user = User.find(params[:id])
		if @user.update_attributes(params[:user])
			flash[:sucess] = "Updated successfully"
			redirect_to @user
			sign_in @user
		else
			render 'edit'
		end
	end

	def index
		@users = User.paginate(page: params[:page])
	end

	def show	
		@user = User.find(params[:id])
		@microposts = @user.microposts.paginate(page:params[:page])
		@micropost = current_user.microposts.build if signed_in?
	end 

	def new
		@user= User.new
	end

	def create
		@user = User.new(params[:user])
		if @user.save
			flash[:sucess] = "Welcome to UX Angels!"
			redirect_to @user
			sign_in @user
		else
			#flash[:error] = @user.errors.full_messages
			render 'new'
		end
	end

	def destroy
		User.find(params[:id]).destroy
		flash[:success] = "User deleted successfully"
		redirect_to users_path
	end

# ensure only signed in users can view pages -------------

private

	def correct_user
		@user = User.find(params[:id])
		unless current_user?(@user)
			redirect_to(signin_path)
		end	
	end

# end ---------------------
end