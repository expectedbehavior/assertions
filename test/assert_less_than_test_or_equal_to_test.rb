#!/usr/bin/env ruby
require (File.expand_path "../test_helper", __FILE__)

class AssertLessThanOrEqualToTest < Test::Unit::TestCase
  def test_assert_less_than_or_equal_to_4_5_succeeds
    assert_less_than_or_equal_to(4, 5)
  end

  def test_assert_less_than_or_equal_to_4_4_succeeds
    assert_less_than_or_equal_to(4, 4)
  end

  def test_assert_less_than_or_equal_to_5_4_fails
    assert_raises(Test::Unit::AssertionFailedError) { assert_less_than_or_equal_to(5, 4) }
  end
end
