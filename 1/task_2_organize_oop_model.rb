class NamedObject
  attr_reader :name

  def initialize name
   @name = name 
  end
end

class Human < NamedObject
  def invite invitee
    invitee
  end

  def to_drink drink
    "#{@name} agrees to drink some #{drink.name} with you!"
  end
end

Drink = Class.new(NamedObject)

volodya = Human.new('Volodya')
ira = Human.new('Ira')
coffee = Drink.new('Latte')

puts volodya.invite(ira).to_drink coffee