#!/usr/bin/env ruby
require File.expand_path("../test_helper", __FILE__)

class AssertSortedTest < Test::Unit::TestCase
  def test_assert_sorted_on_1_fails
    assert_raise_message("enum must be enumerable", ArgumentError) do
      assert_sorted 1
    end
  end

  def test_assert_sorted_on_empty_array_succeeds
    assert_sorted []
  end

  def test_assert_sorted_on_length_one_array_succeeds
    assert_sorted [1]
  end

  def test_assert_sorted_on_sorted_array_succeeds
    assert_sorted [1,2,4,8]
  end

  def test_assert_sorted_on_unsorted_array
    assert_raises(Test::Unit::AssertionFailedError) { assert_sorted [4,2,1,8] }
  end
end
