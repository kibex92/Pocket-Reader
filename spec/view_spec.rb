require_relative 'reader_helper'

begin
  require 'post_factory'
  require 'view'
rescue LoadError
end

reader_helper = ReaderHelper.new(
  file_name: 'view',
  class_name: 'View'
)

describe 'View', unless: reader_helper.file_and_class_valid? do
  it '`view.rb` file should exist' do
    expect(reader_helper.file_exists?).to be(true)
  end

  it 'View class should be defined' do
    expect(reader_helper.class_defined?).to be(true)
  end
end

describe 'View', if: reader_helper.file_and_class_valid? do
  let(:view) { View.new() }

  describe '#display' do
    it 'should display posts' do
      posts = []
      posts << PostFactory.build(path: 'path', author: 'author', title: 'title', content: 'content', read: false)
      expect(STDOUT).to receive(:puts).with(/.*(title).*/)
      view.display(posts)
    end
  end
end