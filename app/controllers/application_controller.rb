class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  rescue_from ActiveRecord::RecordNotFound, :with => :record_not_found

  def record_not_found
  	render status: 422, json: {
  		status: 422,
  		errors: "Id provided does not match a record"
  		}.to_json
  end

end
