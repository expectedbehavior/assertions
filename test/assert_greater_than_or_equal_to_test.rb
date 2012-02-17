#!/usr/bin/env ruby
require (File.expand_path "../test_helper", __FILE__)

class AssertGreaterThanOrEqualToTest < Test::Unit::TestCase
  def test_assert_greater_than_or_equal_to_5_4_succeeds
    assert_greater_than_or_equal_to(5, 4)
  end

  def test_assert_greater_than_or_equal_to_4_4_succeeds
    assert_greater_than_or_equal_to(4, 4)
  end

  def test_assert_greater_than_or_equal_to_4_5_fails
    assert_raises(Test::Unit::AssertionFailedError) { assert_greater_than_or_equal_to(4, 5) }
  end
end
