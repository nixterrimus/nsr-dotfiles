require 'rubygems'

# Basic IRB Variables
IRB.conf[:AUTO_INDENT] = true
IRB.conf[:PROMPT_MODE]  = :SIMPLE

# Save History between irb sessions
#require 'irb/ext/save-history'
IRB.conf[:SAVE_HISTORY] = 100
IRB.conf[:HISTORY_FILE] = "#{ENV['HOME']}/.irb-save-history"

# Clear the screen
def clear
	system 'clear'
end

class Object
  # Return only the methods not present on basic objects
  def interesting_methods
    colputs (self.methods - Object.new.methods).sort
  end
end
