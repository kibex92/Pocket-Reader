require_relative 'post_repository_helper'

begin
  require 'post_factory'
rescue  
end

post_repository_helper = PostRepositoryHelper.new(
  file_name: "post",
  class_name: "Post"
)

describe "Post", unless: post_repository_helper.file_and_class_valid? do
  it '`post.rb` file should exist' do
    expect(post_repository_helper.file_exists?).to be(true)
  end

  it '`Post` class should be defined' do
    expect(post_repository_helper.class_defined?).to be(true)
  end
end


describe 'Post', if: post_repository_helper.file_and_class_valid? do
  let(:post) { PostFactory.build("", "", "") }

  describe '#author' do
    it 'should return the name of the author' do
      expect(post).to respond_to :author
    end
  end

    describe '#title' do
    it 'should return the title of the post' do
      expect(post).to respond_to :title
    end
  end

    describe '#content' do
    it 'should return the content of the post' do
      expect(post).to respond_to :content
    end
  end

  describe '#initialize' do
     it 'should create a post with a list of attributes' do
      post = PostFactory.build("Boris", "Cool Dev", "Testing my tests")
      expect(post.author).to eq 'Boris'
      expect(post.title).to eq 'Cool Dev'
      expect(post.content).to eq 'Testing my tests'
    end
  end
end
