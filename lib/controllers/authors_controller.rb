require_relative '../repositories/author_repository'
class AuthorsController
  def initialize(author_repo)
    @author = author_repo
  end

  
end