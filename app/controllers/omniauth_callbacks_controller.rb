class OmniauthCallbacksController < ApplicationController
	def facebook
		auth = request.env["omniauth.auth"]
		#raise auth.to_yaml
		info = auth['info']
		#puts info.email
		#puts info.name
		#puts auth.provider
		#puts auth.uid
		data = {
			name: info.name,
			lastname: "",
			username: info.name,
			email: info.email,
			provider: auth.provider,
			uid: auth.uid
		}
		@user = User.find_or_create_by_omniauth(data)
		puts @user
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

	def twitter
		auth = request.env["omniauth.auth"]
		#raise auth.to_yaml
		info = auth['info']
		#puts info.name
		#puts info.nickname
		#puts auth.provider
		#puts auth.uid
		data = {
			name: info.name,
			lastname: "",
			username: info.nickname,
			email: "",
			provider: auth.provider,
			uid: auth.uid
		}
		@user = User.find_or_create_by_omniauth(data)
		puts @user
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