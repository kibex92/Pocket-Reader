require_relative '../repositories/author_repository'
require_relative '../views/authors_view'

class AuthorsController
  def initialize(author_repo)
    @author_repo = author_repo
    @authors_view = AuthorsView.new
    @posts_view = PostsView.new
  end

  def show
    authors = @author_repo.all
    @authors_view.display(authors)
  end

  def posts
    show
    id = @authors_view.ask_for("Id")
    author = @author_repo.find(id)
    @posts_view.display(author.posts)
  end

  def info
    show
    id = @authors_view.ask_for("Id")
    author = @author_repo.find(id)
    @authors_view.display_info(author)
  end
end
