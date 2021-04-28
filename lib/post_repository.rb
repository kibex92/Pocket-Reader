require 'csv'

class PostRepository
  def initialize(csv_path)
    @csv = csv_path
    @posts = []
    load_csv
  end

  def all
    @posts
  end

  def add_post(post)
    @posts << post
    write_csv
  end

  def find(index)
    @posts[index]
  end

  def done!(index)
    post = find(index)
    post.read = true
    write_csv
  end
  
  private

  def load_csv
    CSV.foreach(@csv) do |row|
      read = row[4] == 'true'
      @posts << Post.new(path: row[0],
                         author: row[1],
                         title: row[2], 
                         content: row[3], 
                         read: read)
    end
  end

  def write_csv
    CSV.open(@csv, 'wb') do |csv|
      @posts.each do |post|
        csv << [post.path, post.author, post.title, post.content, post.read]
        end
    end
  end
end