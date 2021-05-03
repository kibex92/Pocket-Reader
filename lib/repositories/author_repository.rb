require 'csv'
require_relative '../models/author'

class AuthorRepository
  def initialize(csv_path)
    
    @csv = csv_path
    @authors = []
    @next_id = @authors.empty? ? 1 : @authors.last.id + 1
    load_csv if File.exist?(@csv)
  end

  def all
    @authors
  end

  def add(author)
    author.id = @next_id
    @authors << author
    write_csv
  end

  def find(id)
    @authors.find { |author| author.id == id }
  end

  def find_by_nickname(nickname)
    @authors.find { |author| author.nickname == nickname }
  end

  private

  def load_csv
    csv_options = { headers: :first_row, header_converters: :symbol }
    CSV.foreach(@csv, csv_options) do |row|
      row[:id] = row[:id].to_i
      @authors << Author.new(row)
    end
  end

  def write_csv
    CSV.open(@csv, 'wb') do |csv|
      csv << %w[id nickname name description posts_published comments_written]
      @authors.each do |author|
        csv << [author.id, author.nickname, author.name, author.description, author.posts_published, author.comments_written]
      end
    end
  end
end