# step04.rb
class Creature
  traits = [:life, :strength, :charisma, :weapon]
  traits.each do |trait|
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

class Dragon < Creature
  life 1340
  strength 451
  charisma 1020
  weapon 939
end
  