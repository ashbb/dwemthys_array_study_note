# step12.rb
class Creature
  def self.life val
    @traits ||= {}
    @traits[:life] = val
    p @traits # debug
  end
  
  def self.traits
    @traits
  end
  
  def initialize
    @life = self.class.traits[:life]
  end
  
  attr_reader :life
end

class Rabbit < Creature
  life 10
end

r = Rabbit.new
p r.life