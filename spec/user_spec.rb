# user_spec.rb
require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validations for User model' do
    before(:each) do
      @user = User.new(name: 'Lilly', posts_counter: 0)
    end

    it 'Name must not be blank' do
      @user.name = nil
      expect(@user).to_not be_valid

      @user.name = 'Lilly'
      expect(@user).to be_valid
    end

    it 'PostsCounter must be an integer greater than or equal to zero' do
      @user.posts_counter = 'string'
      expect(@user).to_not be_valid

      @user.posts_counter = -1
      expect(@user).to_not be_valid

      @user.posts_counter = 1
      expect(@user).to be_valid
    end

    it 'should return less than 3 recent posts' do
      user = User.create(name: 'Test User', posts_counter: 0)
      4.times do |i|
        Post.create(author: user, title: "Test Title #{i}", text: "Test Text #{i}", likes_counter: 0,
                    comments_counter: 0)
      end

      recent_posts = user.recent_posts
      # Ensure that only 3 recent posts are returned
      expect(recent_posts.length).to eq(3)
    end

    it 'updates the posts_counter correctly' do
      user = User.create(name: 'Test User', posts_counter: 0)
      post = Post.create(author: user, title: 'Test Title', text: 'Test Text', likes_counter: 0, comments_counter: 0)

      expect(user.posts_counter).to eq(1)
      post.update_author_posts_counter
      user.reload
      expect(user.posts_counter).to eq(1)
    end
  end
end
