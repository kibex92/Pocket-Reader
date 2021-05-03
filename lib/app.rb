require_relative './repositories/post_repository'
require_relative './controllers/posts_controller'
require_relative './controllers/authors_controller'
require_relative 'router'
require_relative './repositories/author_repository'

posts_csv = File.join(__dir__, "posts.csv")
authors_csv = File.join(__dir__, "authors.csv")

author_repo = AuthorRepository.new(authors_csv)
post_repo = PostRepository.new(posts_csv, author_repo)

posts_controller = PostsController.new(post_repo, author_repo)
authors_controller = AuthorsController.new(author_repo)

router = Router.new(posts_controller, authors_controller)

router.run