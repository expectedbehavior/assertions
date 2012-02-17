#!/usr/bin/env ruby
require (File.expand_path "../test_helper", __FILE__)

class AssertGreaterThanTest < Test::Unit::TestCase
  def test_assert_greater_than_5_4_succeeds
    assert_greater_than(5, 4)
  end

  def test_assert_greater_than_4_4_fails
    assert_raises(Test::Unit::AssertionFailedError) { assert_greater_than(4, 4) }
  end

  def test_assert_greater_than_4_5_fails
    assert_raises(Test::Unit::AssertionFailedError) { assert_greater_than(4, 5) }
  end
end
