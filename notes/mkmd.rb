# mkmd.rb
def read_src name
  IO.readlines('../steps/' + name).collect{|c| "\t" + c}
end

Dir.glob("*.md").each do |file|
  lines = IO.readlines(file)
  open(file, 'w') do |f|
    lines.each do |line|
      new_line = line
      #line.sub(/^# *(.*\.rb)/){new_line = read_src($1)}
      line.sub(/^# *(.*\.rb)/) do
        new_line = ["# [#{$1}](http://github.com/ashbb/dwemthys_array_study_note/blob/master/steps/#{$1})\n\n"]
        new_line << read_src($1)
      end
      f.puts new_line
    end
  end
end
