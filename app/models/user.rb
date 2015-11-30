class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  
  has_many :posts
  has_many :friendships
  #follow_id <- convention  => user_id
  has_many :follows, through: :friendships, source: :friend
  #follower_id <- convention
  has_many :followers_friendships, class_name: "Friendship", foreign_key: "friend_id"
  has_many :followers, through: :followers_friendships, source: :user

  def follow!(amigo_id)
    friendships.create!(friend_id: amigo_id)
  end

  def can_follow?(amigo_id)
    not amigo_id == self.id or friendships.where(friend_id: amigo_id).size() > 0
  end


  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  devise :omniauthable, omniauth_providers: [:facebook, :twitter]

  # sayint to device that is not required that email exists into the app
  def email_required?
    false
  end

  validates :username, presence: true, uniqueness: true, 
            length: {minimum: 5, maximum:20, too_short: "at leat 5 characteres", too_long: "Twitter does not accept more than 20 characteres."},
            format: {with: /([A-Za-z0-9\-\_]+)/, message: " must only contain letters and numbers"}

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
