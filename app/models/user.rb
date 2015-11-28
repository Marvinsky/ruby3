class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  devise :omniauthable, omniauth_providers: [:facebook, :twitter]


  def self.find_or_create_by_omniauth(auth)
  	user = User.where(provider: auth[:provider], uid: auth[:uid]).first
    return user if user
  	unless user
  		user = User.create(
  				name: auth[:name],
  				last_name: auth[:lastname],
  				username: auth[:username],
  				email: auth[:email],
  				uid: auth[:uid],
  				provider: auth[:provider],
  				password: Devise.friendly_token[0,20]
  			)
  	end
  end
end
