#!/usr/bin/env ruby
require (File.expand_path "../test_helper", __FILE__)

class AssertPositiveTest < Test::Unit::TestCase
  def test_assert_positive_1_succeeds
    assert_positive(1)
  end

  def test_assert_positive_1_point_0_succeeds
    assert_positive(1.0)
  end

  def test_assert_positive_0_fails
    assert_raises(Test::Unit::AssertionFailedError) { assert_positive(0) }
  end

  def test_assert_positive_negative_1_fails
    assert_raises(Test::Unit::AssertionFailedError) { assert_positive(-1) }
  end

  def test_assert_positive_negative_1_point_0_succeeds
    assert_raises(Test::Unit::AssertionFailedError) { assert_positive(-1.0) }
  end
end
