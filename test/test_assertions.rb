#!/usr/bin/env ruby

require 'assertions'

require 'test/unit'

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
