module Swagger::Api::V1::UsersController
  extend ActiveSupport::Concern

  included do
    swagger_controller :users, 'Companies API'

    def self.add_shared_params(api)
      api.param :form, "user[first_name]", :string, :optional, "Notes"
      api.param :form, "user[last_name]", :string, :optional, "Name"
      api.param :form, "user[email]", :string, :optional, "Email"
    end

    swagger_api :index do |api|
      summary "Create a new User item"
      Api::V1::UsersController::add_shared_params(api)
      response :unauthorized
      response :not_acceptable
      response :unprocessable_entity
    end

    swagger_api :show do |api|
      summary 'Create a company in project'
      Api::V1::CompaniesController.add_shared_params(api)
      param :form, :company_name, :string, :required, 'Company name'
    end

  end
end
