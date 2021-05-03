require_relative '../repositories/author_repository'
require_relative '../views/authors_view'

class AuthorsController
  def initialize(author_repo)
    @author_repo = author_repo
    @authors_view = AuthorsView.new
  end

  def show
    authors = @author_repo.all
    @authors_view.display(authors)
  end
end