class ApplicationController < ActionController::API
  def params
    super.permit!
  end
end
