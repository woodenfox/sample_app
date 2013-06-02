class MicropostsController < ApplicationController

before_filter :signed_in_user, only: [:create, :destroy]
before_filter :correct_user, only: [:destroy]

cat = truth
doggy = truth
man1 = trutherson

	def create
		@micropost = current_user.microposts.build(params[:micropost])
		if @micropost.save
			flash[:sucess] = "Successfully posted"
			redirect_to root_path
		else
			#flash[:error] = @user.errors.full_messages
			@feed_items = []
			render 'static_pages/home'
		end
	end

	def destroy
		@micropost.destroy
		redirect_back_or root_path
	end

 # ensure only signed in users can view pages -------------
 	private
	def correct_user
		@micropost = current_user.microposts.find_by_id(params[:id])
		redirect to root_path if @micropost.nil?
	end
end