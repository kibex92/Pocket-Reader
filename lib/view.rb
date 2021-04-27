class View
  def display(posts)
    posts.each_with_index do |post, index|
      done = post.read ? "[x]" : "[ ]" 
      puts  "#{done} - #{post.title} (#{post.author})" 
    end
  end

  def ask_for(input)
    puts "#{input}?"
    input == 'Index' ? gets.chomp.to_i - 1 : gets.chomp
  end

  def display_content(post)
    puts post.content
  end
end