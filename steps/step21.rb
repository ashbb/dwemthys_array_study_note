# stpe21.rb
require 'step13-1'

class DwemthysArray < Array
  def method_missing( meth, *args )
    answer = first.send( meth, *args )
    p [first, meth, answer]  # debug
    if first.life <= 0
      puts "[#{ first.class } has died.]"
      shift
      if empty?
        puts "[Whoa.  You decimated Dwemthy's Array!]"
      else
        puts "[Get ready. #{ first.class } has emerged.]"
      end
    end
    answer || 0
  end
end

class Dragon < Creature
  life 2
end

class Godzilla < Creature
  life 9
end

class Creature
  def fight enemy
    enemy.life -= 5
  end
end

class Rabbit < Creature
  def ^ enemy
    fight enemy
  end
end

d = Dragon.new
dwa = DwemthysArray[Dragon.new, Godzilla.new]
r = Rabbit.new

r ^ d
p d.life

r ^ dwa
r ^ dwa
r ^ dwa