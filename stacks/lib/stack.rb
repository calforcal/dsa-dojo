class Stack
  attr_reader :stack
  def initialize
    @stack = []
  end

  def push(value)
    @stack << value
  end

  def count
    @stack.count
  end

  def pop
    @stack.pop
  end

  def peek
    @stack[-1]
  end

  def empty
    @stack.empty?
  end

  def validate(string)
    string.chars.each do |char| 
      if is_opening_brace?(char)
        @stack.push(char)
      elsif is_closing_brace?(char)
        popped = @stack.pop
        if popped.nil?
          return "Syntax Error: Missing Opening Brace"
        elsif is_matching_brace?(popped, char)
          return "Syntax Error: Expecting different closing brace"
        end
      end
    end
    empty ? true : false
  end

  def is_matching_brace?(opening_brace, closing_brace)
    closing_brace != {"{"=>"}", "(" => ")", "["=>"]"}[opening_brace]
  end

  def is_opening_brace?(char)
    ["{", "(", "["].include?(char)
  end

  def is_closing_brace?(char)
    ["}", ")", "]"].include?(char)
  end
end