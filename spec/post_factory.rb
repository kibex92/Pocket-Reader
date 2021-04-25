begin
  require 'post'
rescue LoadError
end

class PostFactory
  def self.build(author, title, content)
    if Post.allocate.method(:initialize).arity == 3
      Post.new(author, title, content)
    else
      attributes = {
        author: author,
        title: title,
        content: content
      }
      Post.new(attributes)
    end
  end
end