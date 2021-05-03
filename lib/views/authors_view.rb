class AuthorsView
  def display(authors)
    authors.each_with_index do |author, index|
      puts "#{index + 1} - #{author.name} (#{author.unread_posts.size} unread)"
    end
  end

  def ask_for(input)
    puts "#{input}?"
    input == "Id" ? gets.chomp.to_i : gets.chomp
  end

  def display_info(author)
    puts "#{author.name} (#{author.nickname})\n\n#{author.description}\n\n#{author.posts_published} - #{author.comments_written}"
  end
end