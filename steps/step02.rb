# step02.rb
class Creature
  trait = :life
  define_method trait do |val|
    @traits ||= {}
    @traits[trait] = val
    p @traits  # debug
  end
end

class Dragon < Creature
  Dragon.new.life 1340
  life 1340
end
