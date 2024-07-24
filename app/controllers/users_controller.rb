class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      @user = User.find_by(name: params[:user][:name])
      if @user && @user.authenticate(params[:user][:password])
        session[:user_id] = @user.id 
        flash[:notice] = "User created successfully"
        # method provided by rails to recognise whether a user who has logged in 
        redirect_to root_path
      end
    else
      flash[:alert] = "User not created"
      render :new, status: :unprocessable_entity
    end
  end


  def destroy
    @user = User.find(params[:id])
    @user.destroy
    redirect_to root_path, status: :see_other
  end

  private
  
  def user_params
    params.require(:user).permit(:name, :password, :password_confirmation)
  end
end