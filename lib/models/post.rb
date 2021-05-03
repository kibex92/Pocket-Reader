class Post
  attr_reader :path, :title, :content
  attr_accessor :read, :author, :id

  def initialize(params = {})
    @path = params[:path]
    @author = params[:author]
    @title = params[:title]
    @content = params[:content]
    @read = params[:read] || false
    @id = params[:id]
  end
end
