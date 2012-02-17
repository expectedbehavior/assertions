#!/usr/bin/env ruby
require (File.expand_path "../test_helper", __FILE__)

class AssertLessThanTest < Test::Unit::TestCase
  def test_assert_less_than_4_5_succeeds
    assert_less_than(4, 5)
  end

  def test_assert_less_than_4_4_fails
    assert_raises(Test::Unit::AssertionFailedError) { assert_less_than(4, 4) }
  end

  def test_assert_less_than_5_4_fails
    assert_raises(Test::Unit::AssertionFailedError) { assert_less_than(5, 4) }
  end
end
