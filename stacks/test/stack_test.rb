require 'minitest'
require 'minitest/autorun'
require './lib/stack.rb'

class StackTest < Minitest::Test
  def test_it_pushes
    stack = Stack.new
    stack.push("A")
    stack.push("B")
    stack.push("C")
    assert_equal(3, stack.count)
  end

  def test_it_pops
    stack = Stack.new
    stack.push("A")
    stack.push("B")
    stack.push("C")
    assert_equal("C", stack.pop)
    assert_equal("B", stack.pop)
    assert_equal("A", stack.pop)
  end

  def test_it_peeks
    stack = Stack.new
    stack.push("A")
    stack.push("B")
    stack.push("C")
    assert_equal("C", stack.peek)
    assert_equal("C", stack.pop)
    assert_equal("B", stack.peek)
  end

  def test_it_empty
    stack = Stack.new
    stack.push("A")
    stack.push("B")
    stack.push("C")
    assert_equal(false, stack.empty)
    assert_equal("C", stack.pop)
    assert_equal(false, stack.empty)
    assert_equal("B", stack.pop)
    assert_equal(false, stack.empty)
    assert_equal("A", stack.pop)
    assert_equal(true, stack.empty)
  end

  def test_it_validate
    stack = Stack.new
    assert_equal(true, stack.validate("()"))
    assert_equal(false, stack.validate("("))
    stack = Stack.new
    assert_equal("Syntax Error: Missing Opening Brace", stack.validate("())"))
  end

  def test_it_validates_better
    stack = Stack.new
    assert_equal(true, stack.validate("({()})"))
    assert_equal("Syntax Error: Expecting different closing brace", stack.validate("{}[](]"))
  end

  def test_it_validates_with_stuff
    stack = Stack.new
    assert_equal(true, stack.validate("(MCMC!!!)"))
    assert_equal("Syntax Error: Expecting different closing brace", stack.validate("{Michael()Motor[Cycle)}"))
  end
end