#!/usr/bin/env ruby
require (File.expand_path "../test_helper", __FILE__)

class AssertNotTest < Test::Unit::TestCase
  def assert_not_false_succeeds
    assert_not false
  end

  def test_assert_not_nil_succeeds
    assert_not nil
  end

  def test_assert_not_true_fails
    assert_raises(Test::Unit::AssertionFailedError) { assert_not true }
  end

  def test_assert_not_5_fails
    assert_raises(Test::Unit::AssertionFailedError) { assert_not 5 }
  end
end
