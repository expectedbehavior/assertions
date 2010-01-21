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

    #
    # Verify an enumerable is sorted
    #
    assert_sorted([1,2,3])

    #
    # Verify an enumerable is sorted descending
    #
    assert_sorted_desc([3,2,1])

    #
    # Verify an enumerable is sorted based on a key
    #
    assert_sorted_by(:key, [{:key => 1}, {:key => 2}])

    #
    # Verify an enumerable is sorted descending based on a key
    #
    assert_sorted_by(:key, [{:key => 2}, {:key => 1}])
  end
end
