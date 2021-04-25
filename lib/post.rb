class Post
  attr_reader :author, :title, :content

  def initialize(author, title, content)
    @author = author
    @title = title
    @content = content
  end
end