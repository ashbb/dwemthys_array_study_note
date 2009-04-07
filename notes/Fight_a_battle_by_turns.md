Fight a battle by turns
=======================

Now, my rabbit can fight a monster one-on-one like this:

	d = Dragon.new
	r = Rabbit.new
	r ^ d

But, Dwemthy's Array is an array, not an creature itself. How do I define Dwemthy's Array?!

Look at the [class DwemthysArray](http://github.com/ashbb/dwemthys_array_study_note/blob/master/whys_code/dwemthy.rb). \_why uses the mehtod `method_missing`.

Let me try hacking!

# [step21.rb](http://github.com/ashbb/dwemthys_array_study_note/blob/master/steps/step21.rb)

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

Output is:

	line-A#  >ruby step21.rb
	line-B#  {:life=>10}
	line-C#  {:bombs=>3, :life=>10}
	line-D#  10
	line-E#  3
	line-F#  {:life=>2}
	line-G#  {:life=>9}
	line-H#  -3
	line-I#  [#<Dragon:0x2b60178 @life=2>, :life, 2]
	line-J#  [#<Dragon:0x2b60178 @life=-3>, :life=, -3]
	line-K#  [Dragon has died.]
	line-L#  [Get ready. Godzilla has emerged.]
	line-M#  [#<Godzilla:0x2b60128 @life=9>, :life, 9]
	line-N#  [#<Godzilla:0x2b60128 @life=4>, :life=, 4]
	line-O#  [#<Godzilla:0x2b60128 @life=4>, :life, 4]
	line-P#  [#<Godzilla:0x2b60128 @life=-1>, :life=, -1]
	line-Q#  [Godzilla has died.]
	line-R#  [Whoa.  You decimated Dwemthy's Array!]
	line-S#  >Exit code: 0


- step21.rb, line 2: step13-1.rb is modified just one word from step13.rb. Replaced `attr_reader` to `attr_accessor` in the Creature class.

- output line-A to -E: Thease lines are the same as the result of step13.rb.

- output line-F: The result of line 22.

- output line-G: The result of line 26.

- output line-H: The result of line 46.

- output line-I to -S: The result of line 48-50.


A bit more explanation is:

- line 48 r ^ dwa -> 37 fight enemy -> 31 enemy.life -> (call method_missing) -> 6 send the message `life` to the `Dragon` object) -> 7 output line-I -> 7 output line-J -> 8 -> 9 output line-K -> 10 -> 11 -> 14 output link-L

- line 49 r ^ dwa -> 37 fight enemy -> 31 enemy.life -> (call method_missing) -> 6 send the message `life` to the `Dragon` object) -> 7 output line-M -> 7 output line-N -> 8 -> 17

- line 50 r ^ dwa -> 37 fight enemy -> 31 enemy.life -> (call method_missing) -> 6 send the message `life` to the `Dragon` object) -> 7 output line-O -> 7 output line-P -> 8 -> 9 output line-Q -> 10 -> 11 -> 12 output R

We can transfer the message to any object with `method_missing`. Cool!

Finally, I can understood Dwemthy's Array. :)

