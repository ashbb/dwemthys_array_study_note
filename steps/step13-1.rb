# step13-1.rb
class Creature
  def self.traits *arr
    return @traits if arr.empty?
    attr_accessor *arr
    
    arr.each do |trait|
      meta = (class << self; self; end)
      meta.instance_eval do
        define_method trait do |val|
          @traits ||= {}
          @traits[trait] = val
          p @traits  # debug
        end
      end
    end
  end
  
  def initialize
    self.class.traits.each do |trait,val|
      instance_variable_set("@#{trait}", val)
    end
  end
  
  traits :life, :strength, :charisma, :weapon
end

class Rabbit < Creature
  traits :bombs
  life 10
  bombs 3
end

r = Rabbit.new
p r.life
p r.bombs
