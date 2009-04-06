# step11.rb
class Creature
  def self.life val
    @traits ||= {}
    @traits[:life] = val
    p @traits # debug
  end
end

class Rabbit < Creature
  life 10
end

r = Rabbit.new
p r.instance_variables
p Rabbit.instance_variables
p r.life
