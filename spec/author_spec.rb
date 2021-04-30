require_relative 'reader_helper'

begin
  require 'author'
rescue LoadError
end

reader_helper = ReaderHelper.new(
  file_name: 'author',
  class_name: 'Author'
)

describe 'Author', unless: reader_helper.file_and_class_valid? do
  it '`author.rb` file should exist' do
    expect(reader_helper-file_exists?).to be(true)
  end

  it 'Author class should be defined' do
    expect(reader_helper.class_defined?).to be(true)
  end
end

