class OmniauthCallbacksController < ApplicationController
	def facebook
		auth = request.env["omniauth.auth"]
		raise auth.to_yaml
		data = {
			name: auth.info.first_name,
			lastname: auth.info.last_name,
			username: auth.info.nickname,
			email: auth.info.email,
			provider: auth.provider,
			uid: auth.uid
		}
	end
end