require_relative './repositories/post_repository'
require_relative './controllers/posts_controller.rb'
require_relative 'router'
require_relative './repositories/author_repository'

posts_csv = File.join(__dir__, "posts.csv")
authors_csv = File.join(__dir__, "authors.csv")

author_repo = AuthorRepository.new(authors_csv)
post_repo = PostRepository.new(posts_csv, author_repo)

controller = PostsController.new(post_repo, author_repo)
router = Router.new(controller)

router.run