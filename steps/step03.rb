# step03.rb
class Creature
  trait = :life
  meta = (class << self; self; end)
  meta.instance_eval do
    define_method trait do |val|
      @traits ||= {}
      @traits[trait] = val
      p @traits  # debug
    end
  end
end

class Dragon < Creature
  life 1340
end