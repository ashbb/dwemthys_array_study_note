# step05.rb
class Creature
  def self.traits *arr
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
  traits :life, :strength, :charisma, :weapon
end

class Rabbit < Creature
  traits :bombs
  life 10
  strength 2
  charisma 44
  weapon 4
  bombs 3
end
