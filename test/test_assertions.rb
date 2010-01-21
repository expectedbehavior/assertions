#!/usr/bin/env ruby

require 'assertions'

require 'test/unit'

require 'redgreen'

require 'foo'
require 'seahawk'

class AssertionsTest < Test::Unit::TestCase
  def test_assert_fail
    #
    # Verify that assert_fail fails if the block has
    # no failed assertions.
    #
    failed_assertion = false
    begin
      assert_fail do
      end
    rescue Test::Unit::AssertionFailedError => e
      failed_assertion = true
    end

    if(!failed_assertion)
      flunk("assert_fail incorrectly passed")
    end

    #
    # Verify that assert_fail succeeds when the block
    # has a failed assertion.
    #
    assert_fail do
      assert_equal(4, 5)
    end
  end

  def test_assert_not
    assert_not(false)
    assert_not(nil)
    
    assert_fail do
      assert_not(true)
    end

    assert_fail do
      assert_not(5)
    end
  end

  def test_assert_greater_than
    assert_greater_than(5, 4)

    assert_fail do
      assert_greater_than(4, 4)
    end

    assert_fail do
      assert_gt(4, 5, "test greater than")
    end
  end

  def test_assert_greater_than_or_equal_to_or_equal_to
    assert_greater_than_or_equal_to(5, 4)
    assert_greater_than_or_equal_to(4, 4)

    assert_fail do
      assert_ge(4, 5, "test greater than or equal to")
    end
  end

  def test_assert_less_than
    assert_less_than(4, 5)

    assert_fail do
      assert_less_than(4, 4)
    end

    assert_fail do
      assert_lt(5, 4, "test less than")
    end
  end

  def test_assert_less_than_or_equal_to_or_equal_to
    assert_less_than_or_equal_to(4, 5)
    assert_less_than_or_equal_to(4, 4)

    assert_fail do
      assert_le(5, 4, "test less than or equal to")
    end
  end

  def test_assert_sorted
    assert_raise_message("enum must be enumerable", ArgumentError) do
      assert_sorted 1
    end

    assert_sorted []
    assert_sorted [1]

    assert_sorted [1,2,4,8]

    assert_fail do
      assert_sorted [4,2,1,8], "can you spare some change?"
    end
  end

  def test_assert_sorted_desc
    assert_raise_message("enum must be enumerable", ArgumentError) do
      assert_sorted_desc 1
    end

    assert_sorted_desc []
    assert_sorted_desc [1]

    assert_sorted_desc [8,4,2,1]

    assert_fail do
      assert_sorted_desc [4,2,1,8], "can you spare some change?"
    end
  end

  def test_assert_sorted_by
    assert_raise_message("key must be symbol or string", ArgumentError) do
      assert_sorted_by 12, []
    end

    assert_raise_message("enum must be enumerable", ArgumentError) do
      assert_sorted_by :foo, 1
    end

    assert_raise_message("enum's elements don't respond to the key", ArgumentError) do
      assert_sorted_by :bar, [{ :bar => 1}, { :cow => 2 }]
    end
 
    assert_raise_message("enum's elements don't respond to the key", ArgumentError) do
      assert_sorted_by :bar, [Foo.new(2), Seahawk.new(3)]
    end

    assert_raise_message("enum's elements don't respond to the key", ArgumentError) do
      assert_sorted_by :bar, [Foo.new(1), { :moo => 2 }]
    end
    
    assert_sorted_by :bar,  [{:bar => 1},  {:bar => 2},  {:bar => 3}]
    assert_sorted_by "bar", [{"bar" => 1}, {"bar" => 2}, {"bar" => 3}]
    
    assert_fail do
      assert_sorted_by :bar, [{:bar => 2}, {:bar => 1}, {:bar => 3}]
    end

    foos = []
    4.times do |i|
      foos << Foo.new(i)
    end
    assert_sorted_by :bar, foos
    
    f = foos[0]
    foos[0] = foos[1]
    foos[1] = f
    
    assert_fail do
      assert_sorted_by :bar, foos
    end

    assert_sorted_by :bar, [{ :bar => 1}, Foo.new(2)]
    assert_fail do
      assert_sorted_by :bar, [Foo.new(2), { :bar => 1}]
    end
  end

  def test_assert_sorted_by_desc
    assert_raise_message("key must be symbol or string", ArgumentError) do
      assert_sorted_by_desc 12, []
    end

    assert_raise_message("enum must be enumerable", ArgumentError) do
      assert_sorted_by_desc :foo, 1
    end

    assert_raise_message("enum's elements don't respond to the key", ArgumentError) do
      assert_sorted_by_desc :bar, [{ :bar => 2}, { :cow => 1 }]
    end
 
    assert_raise_message("enum's elements don't respond to the key", ArgumentError) do
      assert_sorted_by_desc :bar, [Foo.new(3), Seahawk.new(2)]
    end

    assert_raise_message("enum's elements don't respond to the key", ArgumentError) do
      assert_sorted_by_desc :bar, [Foo.new(2), { :moo => 1 }]
    end
    
    assert_sorted_by_desc :bar,  [{:bar => 3},  {:bar => 2},  {:bar => 1}]
    assert_sorted_by_desc "bar", [{"bar" => 3}, {"bar" => 2}, {"bar" => 1}]
    
    assert_fail do
      assert_sorted_by_desc :bar, [{:bar => 2}, {:bar => 1}, {:bar => 3}]
    end

    foos = []
    4.times do |i|
      foos << Foo.new(i)
    end
    foos.reverse!
    assert_sorted_by_desc :bar, foos
    
    f = foos[0]
    foos[0] = foos[1]
    foos[1] = f
    
    assert_fail do
      assert_sorted_by_desc :bar, foos
    end

    assert_sorted_by_desc :bar, [{ :bar => 2}, Foo.new(1)]
    assert_fail do
      assert_sorted_by_desc :bar, [Foo.new(1), { :bar => 2}]
    end
  end

  def test_assert_between
    assert_raise_message("Gave the same value for both sides of range. <5> was not equal to <4>", Test::Unit::AssertionFailedError) do
      assert_between 4, 4, 5
    end

    assert_raise_message("<5> was not between <2> and <3>", Test::Unit::AssertionFailedError) do
      assert_between 3, 2, 5
    end
    
    assert_between 4, 8, 6
    assert_between 8, 4, 6
    assert_fail do
      assert_between 4, 6, 8
    end
    
    today     = DateTime.now
    yesterday = today - 1
    tomorrow  = today + 1
    assert_between yesterday, tomorrow,  today
    assert_between tomorrow,  yesterday, today
    
    assert_fail do
      assert_between tomorrow, today, yesterday
    end
  end
  
  def test_assert_raise_message
    #
    # Verify that the assertion passes correctly.
    #
    assert_nothing_raised do
      assert_raise_message("hello, error!", RuntimeError) do
        raise RuntimeError, "hello, error!"
      end
    end

    #
    # Verify that the assertion fails if no exception is thrown.
    #
    assert_fail do
      assert_raise_message("hello, error!", RuntimeError) do
      end
    end

    #
    # Verify that the assertion fails if the wrong kind of
    # exception is thrown.
    #
    assert_fail do
      assert_raise_message("hello, error!", ArgumentError) do
        raise RuntimeError, "hello, error!"
      end
    end

    #
    # Verify that the assertion fails if a different
    # error message is specified.
    #
    assert_fail do
      assert_raise_message("hello, error!", RuntimeError, "test message comparison") do
        raise RuntimeError, "hello, errrr!"
      end
    end
  end
end
