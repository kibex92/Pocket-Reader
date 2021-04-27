begin
  require 'post'
rescue LoadError
end

class PostFactory
  def self.build(params = {})
      attributes = {
        path: params[:path],
        author: params[:author],
        title: params[:title],
        content: params[:content],
        read: false
      }
      Post.new(attributes)
    end
end