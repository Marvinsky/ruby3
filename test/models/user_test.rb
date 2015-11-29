require 'test_helper'

class UserTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

  test "should create an user" do
  	u = User.new(username: "marvin", email:"marvin@gmail.com", password: "12345678")
  	assert u.save
  end

  test "should create an user without email" do
  	u = User.new(username: "marvin", password: "12345678")
  	assert u.save
  end

end
