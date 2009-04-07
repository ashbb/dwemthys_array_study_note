Want to use default setting
===========================

Look at the [scoreline log](http://github.com/ashbb/dwemthys_array_study_note/tree/master/steps/scoreline.log), line 28-29.

Rabbit class object `r` has 5 instance variables with default values. But, when were they setted?

Okay, let me try to think about that. At first, check the instance variables with the method `instance_variables` like this:

# [step11.rb](http://github.com/ashbb/dwemthys_array_study_note/blob/master/steps/step11.rb)

	# step11.rb
	class Creature
	  def self.life val
	    @traits ||= {}
	    @traits[:life] = val
	    p @traits # debug
	  end
	end
	
	class Rabbit < Creature
	  life 10
	end
	
	r = Rabbit.new
	p r.instance_variables
	p Rabbit.instance_variables
	p r.life

Output is:

	>ruby step11.rb
	{:life=>10}
	[]
	["@traits"]
	step11.rb:17: undefined method `life' for #<Rabbit:0x2b82a5c> (NoMethodError)
	>Exit code: 1

Oops, Rabbit object `r` has no instance variables.

Well, let me try to improve the code.

# [step12.rb](http://github.com/ashbb/dwemthys_array_study_note/blob/master/steps/step12.rb)

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

Output is:

	>ruby step12.rb
	{:life=>10}
	10
	>Exit code: 0

I got it!

The above Creature class is added the followings:

1. define class method `traits` which returns the value of class-instance variable `@traits`.

2. define `initialize` method which creats an instance variable `@life` with the class method `traits`.

3. define attribute reader `:life`.

Now, I understood what I have to do. Let me try to improve the Creature class of `step05.rb`.

# [step13.rb](http://github.com/ashbb/dwemthys_array_study_note/blob/master/steps/step13.rb)

	# step13.rb
	class Creature
	  def self.traits *arr
	    return @traits if arr.empty?
	    attr_reader *arr
	    
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

Output is:

	>ruby step13.rb
	{:life=>10}
	{:bombs=>3, :life=>10}
	10
	3
	>Exit code: 0

Done! This works pretty well.

1. class method `traits` is already defined. so, just add the function which returns the value of `@traits` when using with no block. look at line 4.

2. define `initialize` method which creats instance variables dynamically with the method `instance_variable_set`. look at line 19-23.

3. define attribute readers. look at line 5.


Note
----
Looked at [original code](http://github.com/ashbb/dwemthys_array_study_note/tree/master/whys_code/dwemthy.rb).

\_why adds `class_eval` method. But in this case, it's enough without the method.

I guess he used it to introduce Metaprogramming. ;-)
