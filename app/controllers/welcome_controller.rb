class Api::V0::WelcomeController < ApplicationController
  def index
  end

  swagger_controller :welcome, "Welcome"

  swagger_api :create do
    summary "Creates a new User"
    param :form, :first_name, :string, "First name"
    param :form, :last_name, :string, "Last name"
    param :form, :email, :string, :required, "Email address"
    param :form, :password, :string, :required, "Password"
    param :form, :password_confirmation, :string, :required, "Password Confirmation"
    response :unauthorized
    response :not_acceptable
  end
end
