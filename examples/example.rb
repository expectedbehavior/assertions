#!/usr/bin/env ruby
require 'rubygems'
require 'assertions'

require 'test/unit'

class Tests < Test::Unit::TestCase
  def test_assertions
    #
    # Verify that 4 > 5 is false.
    #
    assert_not(4 > 5)

    #
    # Verify that 4 < 5
    #
    assert_less_than(4, 5)
    
    #
    # Verify that 4 < 5 again, but this time with the
    # shorter alias.
    #
    assert_lt(4, 5)
    
    #
    # Verify that 5 >= 5
    #
    assert_ge(5, 5)
    
    #
    # Verify that the specified exception is raised.
    #
    assert_raise_message("Hello, exception!", RuntimeError) do
      raise "Hello, exception!"
    end
    
    #
    # Verify that an assertion failed.
    #
    assert_fail do
      assert_equal(5, 4)
    end
  end
end
