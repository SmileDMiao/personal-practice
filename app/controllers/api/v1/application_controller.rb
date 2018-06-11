module Api
	module V1

		class ApplicationController < ActionController::API
			
			# 记录api的response body
			def append_info_to_payload(payload)
				super
				payload[:response] = JSON.parse(response.body)
				payload[:type] = 'Api'
			end

		end

	end
end
