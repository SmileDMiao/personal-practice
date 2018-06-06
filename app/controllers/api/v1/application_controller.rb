module Api
	module V1

		class ApplicationController < ActionController::API
			
			# 记录api的response body
			def append_info_to_payload(payload)
				super
				payload[:response] = response.body
			end

		end

	end
end
