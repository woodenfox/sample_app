class UsersController < ApplicationController

	def show	
		@user = User.find(params[:id])
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
end
