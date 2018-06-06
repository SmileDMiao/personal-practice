module Api
	module V1

		class UsersController < Api::V1::ApplicationController

			def index
				response = HTTParty.get('http://apis.juhe.cn/idcard/index', 	{query: {cardno: '32092419921103213X', dtype: 'json', key: '85f856b53bff832789a33690af0ce501'}})
				render json: response
			end

			def show
				user = User.find(params[:id])
				render json: user
			end

		end

	end
end