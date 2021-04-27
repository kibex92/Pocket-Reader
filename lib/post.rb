class Post
  attr_reader :path, :author, :title, :content
  attr_accessor :read

  def initialize(params = {})
    @path = params[:path]
    @author = params[:author]
    @title = params[:title]
    @content = params[:content]
    @read = params[:read] || false
  end
end