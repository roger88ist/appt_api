class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  rescue_from ActiveRecord::RecordNotFound, :with => :record_not_found

  def record_not_found
  	render status: 404, json: {
  		status: 404,
  		errors: "Id Not Found"
  		}.to_json
  end

end
