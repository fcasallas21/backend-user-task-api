module Api
  module V1
    class UsersController < ApplicationController
      before_action :authorize_request, unless: -> { Rails.env.test? }
      def index
        users = User.includes(:tasks).paginate(page: params[:page], per_page: 10)
        render json: users
      end

      def show
        user = User.find(params[:id])
        render json: user
      end
    end
  end
end
