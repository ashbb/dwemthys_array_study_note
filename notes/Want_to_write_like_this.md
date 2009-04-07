Want to write like this
=======================

class Dragon
------------

	class Dragon < Creature
	  life 1340
	  strength 451
	  charisma 1020
	  weapon 939
	end

What's this?... This is a Ruby code, NOT data file. The `life`, `strength`, `charisma` and `weapon` are class methods defined in the class `Creature`.

The above code sets Dragon's traits, four default values with class methods.

Okay, I can define the class method. It's not so difficult.

# [step01.rb](http://github.com/ashbb/dwemthys_array_study_note/blob/master/steps/step01.rb)

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

Output is:

	>ruby step01.rb
	{:life=>1340}
	{:life=>1340, :strength=>451}
	>Exit code: 0

This code works well. But I feel depressed for more coding to define `charisma` and `weapon` for Dragon class. Then to define Rabbit class, ScubaArgentine class, IndustrialRaverMonkey class and so on... Damn!

Now I need to study something... **Metaprogramming**.

I found the method `define_method`. It can define methods dynamically.

Okay, let me try.

# [step02.rb](http://github.com/ashbb/dwemthys_array_study_note/blob/master/steps/step02.rb)

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

Output is:

	>ruby step02.rb
	{:life=>1340}
	step02.rb:13: undefined method `life' for Dragon:Class (NoMethodError)
	>Exit code: 1

Oops, I can create instance method but not create class method.

I have to create **metaclass** and use the method `instance_eval`.

# [step03.rb](http://github.com/ashbb/dwemthys_array_study_note/blob/master/steps/step03.rb)

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

Output is:

	>ruby step03.rb
	{:life=>1340}
	>Exit code: 0

I got it!

The below is a bit imporved code to create multi methods.

# [step04.rb](http://github.com/ashbb/dwemthys_array_study_note/blob/master/steps/step04.rb)

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
	  

Output is:

	>ruby step04.rb
	{:life=>1340}
	{:life=>1340, :strength=>451}
	{:life=>1340, :strength=>451, :charisma=>1020}
	{:life=>1340, :strength=>451, :charisma=>1020, :weapon=>939}
	>Exit code: 0


class Rabbit
------------

	class Rabbit < Creature
	  traits :bombs
	  life 10
	  strength 2
	  charisma 44
	  weapon 4
	  bombs 3
	end

Wow, new class method `bombs` is available in the Rabbit class! Despite it's not appeared in the Creature class!

Look at the below code. So, cool!!

# [step05.rb](http://github.com/ashbb/dwemthys_array_study_note/blob/master/steps/step05.rb)

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

Output is:

	>ruby step05.rb
	{:life=>10}
	{:strength=>2, :life=>10}
	{:strength=>2, :charisma=>44, :life=>10}
	{:strength=>2, :charisma=>44, :weapon=>4, :life=>10}
	{:strength=>2, :charisma=>44, :weapon=>4, :bombs=>3, :life=>10}
	>Exit code: 0


Looked at [original code](http://github.com/ashbb/dwemthys_array_study_note/tree/master/whys_code/dwemthy.rb).

Now, I can understand the line 5, 8, 15-22, 37. :-D

