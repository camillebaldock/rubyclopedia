class UsersController < ApplicationController
  def show
  	@users = User.where("LOWER(username) = ?", params[:username].downcase)
  	if @users.count == 1
  	  @user = @users.first 
      respond_to do |format|
        format.html # show.html.erb
        format.json { render json: @user }
      end
    else
      redirect_to root_path
    end
  end
end
