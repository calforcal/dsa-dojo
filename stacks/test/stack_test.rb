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

  def test_it_html_parse_level_1
    stack = Stack.new
    assert_equal(true, stack.validate_html("<p>Hello World</p>"))
    assert_equal(false, stack.validate_html("<pHello World</p>"))
    stack.stack = []

    assert_equal(true, stack.validate_html("<span>Hello World</span>"))
    assert_equal(false, stack.validate_html("<span>pHello World</spa"))
    stack.stack = []

    assert_equal(true, stack.validate_html("<code>Hello World</code>"))
    assert_equal(false, stack.validate_html("<>pHello World</code>"))
  end

  def test_it_parse_level_2
    stack = Stack.new
    assert_equal(true, stack.validate_html("<body>Hello World</body>"))
    assert_equal(false, stack.validate_html("<bodyHello World</body>"))
    stack.stack = []

    assert_equal(true, stack.validate_html("<ul>Hello World</ul>"))
    assert_equal(false, stack.validate_html("<ul>pHello World</spa"))
    stack.stack = []

    assert_equal(true, stack.validate_html("<ol>Hello World</ol>"))
    assert_equal(false, stack.validate_html("<ul>pHello World</ol>"))
    stack.stack = []

    assert_equal(true, stack.validate_html("<li>Hello World</li>"))
    assert_equal(false, stack.validate_html("<lil>pHello World</li>"))
  end

  def test_it_parse_level_3_nested
    stack = Stack.new
    assert_equal(true, stack.validate_html("<body>Hello World</body>"))
    assert_equal(false, stack.validate_html("<bodyHello World</body>"))
  end
end