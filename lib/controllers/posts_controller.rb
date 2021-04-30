require_relative '../models/post'
require_relative '../views/posts_view'
require_relative '../services/reader_scraper'
require 'pry'
class PostsController
  
  def initialize(post_repository, author_repository)
    @post_repository = post_repository
    @author_repository = author_repository
    @view = PostsView.new
  end

  def show
    list
  end

  def create
    path = @view.ask_for('path')
    scraped_items = ReaderScraper.new(path).call

    post = scraped_items[:post]
    
    author = scraped_items[:author]

    @author_repository.add(author) unless @author_repository.find_by_nickname(author.nickname)
    
    author.add_post(post)
    @post_repository.add(post)
    list
  end

  def read
    list
    index = @view.ask_for('Index')
    post = @post_repository.find_by_index(index)
    @view.display_content(post)
  end

  def mark_as_read
    list
    index = @view.ask_for('Index')
    @post_repository.done!(index)
    list
  end

  private





  def list
    @view.display(@post_repository.all)
  end

 


end