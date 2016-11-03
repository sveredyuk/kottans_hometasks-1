class Calculator
  def initialize
    @a = get_operand 'A'
    @b = get_operand 'B'
    @operation = get_operation
  end

  def calculate
    result = @a.public_send(@operation, @b)
    result.finite? ? result : "Division by zero? What a pity!"
  end

  private

  def get_operand operand
    print "Please, enter #{operand}: "

    begin
      input = Float gets.chomp
    rescue ArgumentError => e
      puts "Sorry, incorrect input. Try again."
      get_operand operand
    end

  end

  def get_operation
    print "What would you like to do with them (+, -, *, /) ?: "
    operation = valid_operation? gets.chomp
  end

  def valid_operation? operation
    if %w{+ - * /}.include? operation
      operation
    else
      puts "I have no idea how to handle this :( Give me something else."
      get_operation
    end
  end

end

calc = Calculator.new
puts "Result: #{calc.calculate}"