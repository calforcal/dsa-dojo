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
end