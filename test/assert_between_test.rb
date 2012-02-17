#!/usr/bin/env ruby
require File.expand_path("../test_helper", __FILE__)

class AssertBetweenTest < Test::Unit::TestCase
  def test_assert_between_4_4_5_fails
    assert_raise_message("Gave the same value for both sides of range. <5> was not equal to <4>",
                         Test::Unit::AssertionFailedError) do
      assert_between 4, 4, 5
    end
  end

  def test_assert_between_3_2_5_fails
    assert_raise_message("<5> was not between <2> and <3>", Test::Unit::AssertionFailedError) do
      assert_between 3, 2, 5
    end
  end

  def test_assert_between_4_8_6_succeeds
    assert_between 4, 8, 6
  end

  def test_assert_between_8_4_6_succeeds
    assert_between 8, 4, 6
  end

  def test_assert_between_on_now_between_past_and_future_times_succeeds
    now = Time.now
    before = now - 1
    after = now + 1
    assert_between before, after, now
  end

  def test_assert_between_on_now_between_future_and_past_times_succeeds
    now = Time.now
    before = now - 1
    after = now + 1
    assert_between after, before, now
  end

  def test_assert_between_on_before_time_between_now_and_future_times_succeeds
    now = Time.now
    before = now - 1
    after = now + 1
    assert_raises(Test::Unit::AssertionFailedError) { assert_between after, now, before }
  end
end
