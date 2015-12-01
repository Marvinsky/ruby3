class Friendship < ActiveRecord::Base
  belongs_to :friend, class_name: "User"
  belongs_to :user, class_name: "User"
  include PublicActivity::Model
  tracked owner: Proc.new{|controller, model| controller.current_user}
end
