require 'open-uri'
require 'nokogiri'
require 'pry'
class ReaderScraper
  attr_reader :post_path
  URL = "https://dev.to/"

  def initialize(post_path)
    @post_path = post_path
  end

  def call
    

    post = scrape_post
    author = scrape_author

    { post: post, author: author }
  end

  private

  def scrape_page
    begin
      html = URI.open("#{URL}#{@post_path}")
      Nokogiri::HTML(html)
    rescue OpenURI::HTTPError => e
      handle_error(e)
    end
  end


  def scrape_post
    params = { path: @post_path }
    doc = scrape_page
    params[:title] = doc.search('h1').first.children.text.strip
    paragraphs = doc.search('.crayons-article__main p')
    params[:content] = paragraphs.map do |element|
      element.text.strip
        end.join("\n\n")
    Post.new(params)
  end

  def scrape_author
    params = Hash.new
    nickname = @post_path.split('/').first
    html = URI.open("#{URL}#{nickname}")
    doc = Nokogiri::HTML(html)
    params[:description] = doc.search('.crayons-layout p').first.text
    info = doc.search('.crayons-card--secondary .items-center').map do |e|
      e.text.strip
    end
    params[:nickname] = nickname
    params[:posts_published] = info.find { |element| element.match?("Post") }.split.-(["Post"]).join(" ")

    params[:comments_written] = info.find { |element| element.match?("Comment") }.split.-(["Comment"]).join(" ")

    params[:name] = doc.search(".crayons-title").text.strip
    Author.new(params)
  end

   def handle_error(e)
    puts "404 Not found"
    path = @view.ask_for("Another path")
    scrape_page(path)
  end
end