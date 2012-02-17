#!/usr/bin/env ruby
require File.expand_path("../test_helper", __FILE__)

class AssertSortedDescTest < Test::Unit::TestCase
  def test_assert_sorted_desc_on_1_fails
    assert_raise_message("enum must be enumerable", ArgumentError) do
      assert_sorted_desc 1
    end
  end

  def test_assert_sorted_desc_on_empty_array_succeeds
    assert_sorted_desc []
  end

  def test_assert_sorted_desc_on_length_one_array_succeeds
    assert_sorted_desc [1]
  end

  def test_assert_sorted_desc_on_desc_sorted_array_succeeds
    assert_sorted_desc [8,4,2,1]
  end

  def test_assert_sorted_desc_on_unsorted_array
    assert_raises(Test::Unit::AssertionFailedError) { assert_sorted_desc [4,2,1,8] }
  end
end
