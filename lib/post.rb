class Post
  attr_reader :author, :title, :content, :done

  def initialize(params = {})
    @author = params[:author]
    @title = params[:title]
    @content = params[:content]
    @done = params[:done] || false
  end
end