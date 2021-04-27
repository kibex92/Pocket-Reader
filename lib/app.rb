require_relative 'post_repository'
require_relative 'controller'
require_relative 'router'

csv = File.join(__dir__, "posts.csv")
repo = PostRepository.new(csv)
controller = Controller.new(repo)
router = Router.new(controller)

router.run