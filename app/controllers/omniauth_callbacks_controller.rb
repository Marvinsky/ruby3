class OmniauthCallbacksController < ApplicationController
	def facebook
		auth = request.env["omniauth.auth"]
		#raise auth.to_yaml
		data = {
			name: auth.info.first_name,
			lastname: auth.info.last_name,
			username: auth.info.nickname,
			email: auth.info.email,
			provider: auth.provider,
			uid: auth.uid
		}
		@user = User.find_or_create_by_omniauth(data)
		puts @user
		puts "after printttttt"
		if @user.persisted?
			sign_in_and_redirect @user, event: :authentication
		else
			# If the email was already registered
			# Twitter does not send email of the people
			session[:omniauth_errors] = @user.errors.full_messages.to_sentence unless @user.save
			session[:omniauth_data] = data
			redirect_to new_user_registration_url
		end
	end
end