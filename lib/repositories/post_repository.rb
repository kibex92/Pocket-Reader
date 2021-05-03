require 'csv'
require_relative '../models/post'

class PostRepository
  def initialize(csv_path, author_repo)
    @csv = csv_path
    @author_repo = author_repo
    @posts = []
    @next_id = @posts.empty? ? 1 : @post.last.id + 1
    load_csv if File.exist?(@csv)
  end

  def all
    @posts
  end

  def add(post)
    post.id = @next_id
    @posts << post
    write_csv
  end

  def find_by_index(index)
    @posts[index]
  end

  def find(id)
    @posts.find { |post| post.id == id }
  
  end

  def done!(index)
    post = find_by_index(index)
    post.read = true
    write_csv
  end
  
  private

  def load_csv
    csv_options = { headers: :first_row, header_converters: :symbol }
    CSV.foreach(@csv, csv_options) do |row|
      author = row[:author] = @author_repo.find(row[:author_id].to_i)
      row[:read] = row[:read] == 'true'
      row[:id] = row[:id].to_i
      post = Post.new(row)
      @posts << post
      author.add_post(post)
    end
  end

  def write_csv
    CSV.open(@csv, 'wb') do |csv|
      csv << %w[id path author_id title content read]
      @posts.each do |post|
        csv << [post.id, post.path, post.author.id, post.title, post.content, post.read]
        end
    end
  end
end
