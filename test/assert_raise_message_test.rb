#!/usr/bin/env ruby
require File.expand_path("../test_helper", __FILE__)

class AssertRaiseMessageTest < Test::Unit::TestCase
  def test_assert_raise_message_on_expected_error_succeeds
    assert_raise_message("hello, error!", RuntimeError) do
      raise RuntimeError, "hello, error!"
    end
  end

  def test_assert_raise_message_with_no_exception_fails
    assert_raises(Test::Unit::AssertionFailedError) do
      assert_raise_message("hello, error!", RuntimeError) { }
    end
  end

  def test_assert_raise_message_with_wrong_exception_fails
    assert_raises(Test::Unit::AssertionFailedError) do
      assert_raise_message("hello, error!", ArgumentError) do
        raise RuntimeError, "hello, error!"
      end
    end
  end

  def test_assert_raise_message_with_wrong_error_message_fails
    assert_raises(Test::Unit::AssertionFailedError) do
      assert_raise_message("hello, error!", RuntimeError, "test message comparison") do
        raise RuntimeError, "hello, errrr!"
      end
    end
  end
end
