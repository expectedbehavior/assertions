#!/usr/bin/env ruby
require (File.expand_path "../test_helper", __FILE__)

class AssertNegativeTest < Test::Unit::TestCase
  def test_assert_negative_negative_1_succeeds
    assert_negative(-1)
  end

  def test_assert_negative_negative_1_point_0_succeeds
    assert_negative(-1.0)
  end

  def test_assert_negative_0_fails
    assert_raises(Test::Unit::AssertionFailedError) { assert_negative(0) }
  end

  def test_assert_positive_1_fails
    assert_raises(Test::Unit::AssertionFailedError) { assert_negative(1) }
  end

  def test_assert_positive_1_point_0_succeeds
    assert_raises(Test::Unit::AssertionFailedError) { assert_negative(1.0) }
  end
end
