require 'reader_helper'

begin
  require 'controller'
rescue LoadError
end

reader_helper = ReaderHelper.new(
  file_name: 'controller',
  class_name: 'Controller'
)

describe 'Controller', unless: reader_helper.file_and_class_valid? do
  it '`controller.rb` file should exist' do
    expect(reader_helper.file_exists?).to be(true)
  end

  it 'Controller class should be defined' do
    expect(reader_helper.class_defined).to be(true)
  end
end

describe 'Controller', if: reader_helper.file_and_class_valid? do
  let(:csv_path) { "spec/posts.csv" }
  let(:post_repository) { PostRepository.new(csv_path) }
  let(:controller) { Controller.new(post_repository) }

  describe '#initialize' do
    it 'should store the repo in an instance variable' do
      expect(controller.instance_variable_get(:@post_repository)).to be_a PostRepository
    end
  end

  describe '#list' do
  it 'should return a method for listing posts' do
    expect(controller).to respond_to :list
    end
  end

  describe '#create' do
  it 'should return a method for creating posts' do
    expect(controller).to respond_to :create
    end
  end

  describe '#destroy' do
  it 'should return a method for removing posts' do
    expect(controller).to respond_to :destroy
    end
  end
end