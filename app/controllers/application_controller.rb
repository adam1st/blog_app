class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :null_session
  before_action :authenticate_user!, :except => [:index, :show]
  acts_as_token_authentication_handler_for User, :except => [:index, :show]
  respond_to :html, :json
  
   protected

  def json_request?
    request.format.json?
  end
end
 