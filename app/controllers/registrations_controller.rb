class RegistrationsController < Devise::RegistrationsController
  
  def create
    respond_to do |format|
      format.html {
        super
      }
      format.json {
        @user = User.create(user_params)
        @user.save ? (render :json => {:state => {:code => 0}, :data => @user }) : 
                     (render :json => {:state => {:code => 1, :messages => @user.errors.full_messages} })
      }
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :password)
  end
end 