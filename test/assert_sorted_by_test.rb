#!/usr/bin/env ruby
require File.expand_path("../test_helper", __FILE__)

require "foo"
require "seahawk"

class AssertSortedByTest < Test::Unit::TestCase
  def test_assert_sorted_by_number_fails
    assert_raise_message("key must be symbol or string", ArgumentError) do
      assert_sorted_by 12, []
    end
  end

  def test_assert_sorted_by_on_number_fails
    assert_raise_message("enum must be enumerable", ArgumentError) do
      assert_sorted_by :foo, 1
    end
  end

  def test_assert_sorted_by_on_hash_that_doesnt_respond_to_sort_key_fails
    assert_raise_message("enum's elements don't respond to the key", ArgumentError) do
      assert_sorted_by :bar, [{:bar => 1}, {:cow => 2}]
    end
  end

  def test_assert_sorted_by_on_array_of_objects_that_dont_respond_to_sort_key_fails
    assert_raise_message("enum's elements don't respond to the key", ArgumentError) do
      assert_sorted_by :bar, [Foo.new(2), Seahawk.new(3)]
    end
  end

  def test_assert_sorted_by_on_array_of_objects_and_hash_that_dont_respond_to_sort_key_fails
    assert_raise_message("enum's elements don't respond to the key", ArgumentError) do
      assert_sorted_by :bar, [Foo.new(1), {:moo => 2}]
    end
  end

  def test_assert_sorted_by_on_sorted_array_with_symbol_keys_succeeds
    assert_sorted_by :bar,  [{:bar => 1},  {:bar => 2},  {:bar => 3}]
  end

  def test_assert_sorted_by_on_sorted_array_with_string_keys_succeeds
    assert_sorted_by "bar", [{"bar" => 1}, {"bar" => 2}, {"bar" => 3}]
  end

  def test_assert_sorted_by_on_unsorted_array_fails
    assert_raises(Test::Unit::AssertionFailedError) do
      assert_sorted_by :bar, [{:bar => 2}, {:bar => 1}, {:bar => 3}]
    end
  end

  def test_assert_sorted_by_on_sorted_array_of_objects_succeeds
    foos = [Foo.new(1), Foo.new(2), Foo.new(3)]
    assert_sorted_by :bar, foos
  end

  def test_assert_sorted_by_on_unsorted_array_of_objects_fails
    foos = [Foo.new(3), Foo.new(1), Foo.new(2)]
    assert_raises(Test::Unit::AssertionFailedError) { assert_sorted_by :bar, foos }
  end

  def test_assert_sorted_by_on_sorted_object_mash_succeeds
    assert_sorted_by :bar, [{:bar => 1}, Foo.new(2)]
  end

  def test_assert_sorted_by_on_unsorted_object_mash_fails
    assert_raises(Test::Unit::AssertionFailedError) do
      assert_sorted_by :bar, [Foo.new(2), {:bar => 1}]
    end
  end
end
