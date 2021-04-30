class Author
  attr_reader :name, :nickname, :description, :posts_published, :comments_written, :posts
  attr_accessor :id
  
  def initialize(params = {})
    @nickname = params[:nickname]
    @name = params[:name]
    @description = params[:description]
    @posts_published = params[:posts_published]
    @comments_written = params[:comments_written]
    @posts = []
    @id = params[:id]
  end

  def add_post(post)
    @posts << post
    post.author = self
  end
end