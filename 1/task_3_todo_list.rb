class Todo
  attr_reader :description
  attr_reader :state

  STATES = ['new', 'done', 'canceled']

  def initialize description
    @description = description
    @state = STATES[0]
  end

  def change_state state
    @state = state
  end
end

class TodoList
  attr_reader :list

  def initialize
    @list = []
  end

  def add
    print "Please, describe what you need to do: "
    description = gets.chomp
    if description == ''
      puts "The task is to easy. Give me something else."
      add
    else
      @list << Todo.new(description)
    end
  end

  def display
    @list.each_with_index do |todo, index|
      puts "#{index}. #{todo.description} [#{todo.state}]"
    end
  end

  def select
    print "Please, select TODO by entering it's numer: "

    begin
      input = Integer gets.chomp
    rescue ArgumentError => e
      puts "Sorry, incorrect input. Try again."
      select
    end

    if input < 0 || input > @list.length - 1 
      puts "Out of range"
      select
    else
      selected_todo = @list[input]
    end
  end
end

class App
  ADD = 'add'
  CHANGE = 'change'

  def initialize
    @todo_list = TodoList.new
  end

  def ask
    if @todo_list.list.empty?
      @todo_list.add
      @todo_list.display
      ask
    else
      print "Would you like to 'add' new or 'change' existing TODO? "
      answer = gets.chomp
      handle_answer answer
    end
  end

  def handle_answer answer
    if answer == ADD
      @todo_list.add
      @todo_list.display
      ask
    elsif answer == CHANGE
      change @todo_list.select
      ask
    else
      puts "I have no idea how to handle this :( Give me something else."
      ask
    end
  end

  def change todo
    print "Whould you like to check as 'done' or 'canceled': "
    state = gets.chomp

    if Todo::STATES.include? state
      todo.change_state state
      @todo_list.display
    else
      puts "Sorry, incorrect input. Try again."
      change todo
    end
  end

end

app = App.new.ask