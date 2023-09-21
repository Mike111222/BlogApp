# post_spec.rb
require 'rails_helper'

RSpec.describe Post, type: :model do
  describe 'validations for Post model' do
    before(:each) do
      @user = User.create(name: 'Lilly', posts_counter: 0)
      @post = Post.new(author: @user, title: 'Hello', text: 'This is my first post', likes_counter: 0,
                       comments_counter: 0)
    end

    it 'Title must not be blank' do
      @post.title = nil
      expect(@post).to_not be_valid

      @post.title = 'Hello'
      expect(@post).to be_valid
    end

    it 'Title must not exceed 250 characters' do
      @post.title = 'a' * 251
      expect(@post).to_not be_valid

      @post.title = 'a' * 250
      expect(@post).to be_valid
    end

    it 'CommentsCounter must be an integer greater than or equal to zero' do
      @post.comments_counter = 'string'
      expect(@post).to_not be_valid

      @post.comments_counter = -1
      expect(@post).to_not be_valid

      @post.comments_counter = 1
      expect(@post).to be_valid
    end

    it 'LikesCounter must be an integer greater than or equal to zero' do
      @post.likes_counter = 'string'
      expect(@post).to_not be_valid

      @post.likes_counter = -1
      expect(@post).to_not be_valid

      @post.likes_counter = 1
      expect(@post).to be_valid
    end

    it 'should return less than 5 comments' do
      value = @post.recent_comments.length
      expect(value).to be < 5
    end

    it 'updates the author\'s posts_counter' do
      user = User.create(name: 'Test User', posts_counter: 0)
      post = Post.create(author: user, title: 'Test Title', text: 'Test Text', likes_counter: 0, comments_counter: 0)

      expect(user.posts_counter).to eq(1)
      post.update_author_posts_counter
      user.reload
      expect(user.posts_counter).to eq(1)
    end
  end
end
