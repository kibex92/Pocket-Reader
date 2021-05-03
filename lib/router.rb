class Router
  def initialize(posts_controller, authors_controller)
    @posts_controller = posts_controller
    @authors_controller = authors_controller
    @running = true
  end

  def run
    puts "Welcome to your Pocket Reader!"

    while @running
      display_tasks
      action = gets.chomp.to_i
      route_action(action)
    end
  end

  private

  def route_action(action)
    case action
    when 1 then @posts_controller.show
    when 2 then @posts_controller.create
    when 3 then @posts_controller.read
    when 4 then @posts_controller.mark_as_read
    when 6 then @authors_controller.show
    when 5 then @authors_controller
    when 5 then @authors_controller
    when 5 then @authors_controller
    else
      puts "Please press a number from 1 to 5"
    end 
  end

  def display_tasks
    puts "What do you want to do next?"
    puts "1. List posts"
    puts "2. Save post for later"
    puts "3. Read post"
    puts "4. Mark post as read"
    puts "5. List authors"
    puts "6. List author's posts"
    puts "7. See author info"
    puts "8. Exit"

  end

  def stop
    @running = false
  end
end