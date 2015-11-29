require 'test_helper'

class PostTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

  test "should create a post" do
  	post = Post.create(title: "Title1", content: "Content1")
  	assert post.save
  end

  test "should update a post" do
  	post = posts(:first_post)
  	assert post.update(title: "New title", content: "New content")
  end

  test "should find a post by id" do
  	post_id = posts(:first_post).id
  	post = Post.find(post_id)
  	assert_nothing_raised {Post.find(post_id)}
  	#assert_equal post, posts(:first_post), "Post is not found" 
  end
 
  test "should remove post by id" do
  	post = posts(:first_post)
  	post.destroy
  	assert_raise(ActiveRecord::RecordNotFound) {Post.find(post.id)}
  end

  #TDD
  # 1.- fail the test
  # 2.- make the test pass

  test "should not create post without title" do
  	post = Post.new
  	assert post.invalid?, "Can not create post without title"
  end

  test "should each title must be unique" do
  	post = Post.new
  	post.title = posts(:first_post).title
  	assert post.invalid?, "Two post can not have the same title"
  end
end
