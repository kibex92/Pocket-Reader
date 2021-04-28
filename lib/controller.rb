require_relative 'view'
require 'open-uri'
require 'nokogiri'
require_relative 'post'
require_relative 'post_repository'

class Controller
  URL = "https://dev.to/"

  def initialize(repository)
    @post_repository = repository
    @view = View.new
  end

  def show
    list
  end

  def create
    post = scrape_post
    @post_repository.add_post(post)
    list
  end

  def read
    list
    index = @view.ask_for('Index')
    post = @post_repository.find(index)
    @view.display_content(post)
  end

  def mark_as_read
    list
    index = @view.ask_for('Index')
    @post_repository.done!(index)
    list
  end

  private

  def scrape_post
    path = @view.ask_for('path')
    doc = scrape_page(path)
    author = doc.search('a .crayons-link').first.children.first.text.strip
    title = doc.search('h1').first.children.text.strip
    paragraphs = doc.search('.crayons-article__main p')
    content = paragraphs.map do |element|
      element.text.strip
      end.join("\n\n")
    Post.new(path: path,  author: author, title: title, content: content)
  end

  def scrape_page(path)
    begin
      html = URI.open("#{URL}#{path}")
      Nokogiri::HTML(html)
    rescue OpenURI::HTTPError => e
      handle_error(e)
    end
  end

  def list
    @view.display(@post_repository.all)
  end

  def handle_error(e)
    puts "404 Not found"
    path = @view.ask_for("Another path")
    scrape_page(path)
  end
end