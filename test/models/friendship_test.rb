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

  test "should require a follower_id/friend_id" do
  	@relationship.friend_id = nil
  	assert_not @relationship.valid?
  end


  test "should require a followed/user_id" do
  	@relationship.user_id = nil
  	assert_not @relationship.valid?
  end
end