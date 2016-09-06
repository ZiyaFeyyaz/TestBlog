class WelcomeController < ApplicationController
  def index
  end

  swagger_controller :welcome, "Welcome"

  swagger_api :index do
    summary "Fetches all users"
    response :unauthorized
    response :not_acceptable
  end
end
