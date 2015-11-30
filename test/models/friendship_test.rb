require 'test_helper'

class FriendshipTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  def setup
  	@relationship = Friendship.new(user_id: 1, friend_id: 2)
  end

  test "should be valid" do
  	assert @relationship.valid?
  end
end
