class AuthorsView
  def display(authors)
    authors.each_with_index do |author, index|
      puts "#{index + 1} - #{author.name}"
    end
  end
end