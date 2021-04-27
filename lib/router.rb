class Router
  def initialize(controller)
    @controller = controller
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
    when 1 then @controller.show
    when 2 then @controller.create
    when 3 then @controller.read
    when 4 then @controller.mark_as_read
    when 5 then stop
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
    puts "5. Exit"
  end

  def stop
    @running = false
  end
end