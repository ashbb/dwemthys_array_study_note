# step01.rb
class Creature
  def self.life val
    @traits ||= {}
    @traits[:life] = val
    p @traits # debug
  end
  
  def self.strength val
    @traits ||= {}
    @traits[:strength] = val
    p @traits # debug
  end
end

class Dragon < Creature
  life 1340
  strength 451
end
