require 'csv'
require 'post_factory'
require_relative 'reader_helper'

begin
  require 'post_repository'
rescue LoadError
end

class Helper
  def self.write_csv(file, data)
    CSV.open(file, 'w') do |csv|
      data.each do |row|
        csv.puts(row)
      end
    end
  end
end

reader_helper = ReaderHelper.new(
  file_name: 'post_repository',
  class_name: 'PostRepository'
)

describe 'PostRepository', unless: reader_helper.file_and_class_valid? do
  it '`post_repository.rb` should exist' do
    expect(reader_helper.file_exists?).to be(true)
  end

  it '`PostRepository` class should be defined' do
    expect(reader_helper.class_defined?).to be(true)
  end
end

describe 'PostRepository', if: reader_helper.file_and_class_valid? do
  let(:posts) do
    [
      ["path", "Author A", "Nice Title", "Nice Title - Contenta"],
      ["path1", "Author B", "Title", "Title - Content"],
      ["path2", "Author C", "Another Title", "Another Title - Content"],
      ["path3", "Author D", "Title 2", "Title 2 - Content"]
    ]
  end

  let(:csv_path) { "spec/posts.csv" }

  describe 'without CSV' do
    # Allows initialization without or 1 arguments
    before do
      if PostRepository.instance_method(:initialize).arity == 1
        @post_repository = PostRepository.new(csv_path)
      else
        @post_repository = PostRepository.new()
      end
    end

    describe '#initialize' do
      it 'should create an array @posts' do
        expect(@post_repository.instance_variable_get('@posts')).to be_a(Array)
      end
    end

    describe '#all' do
      it 'should return all posts saved to @posts' do
        @post_repository.instance_variable_set('@posts', [PostFactory.build(path: "somepath", author: "Author", title: "Title", content: "Content")])
        expect(@post_repository.all).to be_a(Array)
        expect(@post_repository.all.first).to be_a(Post)
      end
    end

    describe '#add_post' do
      it 'should add a post to the repo' do
        size_before = @post_repository.all.size
        @post_repository.add_post(PostFactory.build(path: "somepath", author: "Author", title: "Title", content: "Content"))
        expect(@post_repository.all.size).to eq (size_before + 1)
      end
    end
  end

  describe 'with CSV' do
    # On setup reset csv file with recipes
    before do
      Helper.write_csv(csv_path, posts)
      @post_repository = PostRepository.new(csv_path)
    end

    describe '#initialize' do
      it 'should load all posts from CSV in posts.csv' do
        expect(@post_repository.all.size).to eq posts.size
      end
    end

    describe '#all' do
      it 'should give access to all posts' do
        expect(@post_repository).to respond_to :all
        expect(@post_repository.all).to be_a(Array)
      end

      it 'should return an array of Post instances' do
        post = @post_repository.all.first
        expect(post).to be_instance_of(Post), lambda { "Post repository shuold store Post instances, not #{post.class}" }
      end
    end

    describe '#add_post' do
      it 'should store post in the CSV' do
        size_before = @post_repository.all.size
        @post_repository.add_post(PostFactory.build(path: "somepath", author: "Author", title: "Title", content: "Content"))

        # CSV reload
        new_repo = PostRepository.new(csv_path)
        expect(new_repo.all.size).to eq (size_before + 1)
      end
    end
  end
end