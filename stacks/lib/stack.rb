class Stack
  attr_accessor :stack
  def initialize
    @stack = []
    @valid_tags = ["<p>", "<span>", "<code>", "<body>", "<ul>", "<li>", "<ol>"]
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

  def validate_html(string)
    # The catch is that it HAS to start with "<"
    length = string.length - 1

    return if string[0] != "<"
    return "Syntax Error: Missing opening tag" if string[0, 1] == "</"

    i = 0
    while string[i] != ">" && i < length
      push(string[i])
      i += 1
    end
    push(string[i])

    while string[i] != "<" && i < length
      i += 1
    end

    return "Open Tag never closed" if i > length

    if string[i + 1] == "/"
      hash = {}
      hash[string[i]] = true

      while string[i] != ">" && i < length
        hash[string[i]] = true
        i += 1
      end
      hash[string[i]] = true

      all_popped = ""
      popped = ""
      while peek != "<"
        popped = pop
        all_popped.prepend(popped)
        # return "Didnt equal 1" if !hash[popped]
        return false if !hash[popped]
      end
      popped = pop
      all_popped.prepend(popped)
      # return "Didnt Equal 2" if (!hash[popped] || !@valid_tags.include?(all_popped))
      return false if (!hash[popped] || !@valid_tags.include?(all_popped))

    else
      push(string[i])
      while string[i] != ">" && i < length
        push(string[i])
        i += 1
      end
      push(string[i])
    end
    # empty ? true : "Stack not Empty"
    empty ? true : false
  end
end