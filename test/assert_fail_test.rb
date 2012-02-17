#!/usr/bin/env ruby
require (File.expand_path "../test_helper", __FILE__)

class AssertFailTest < Test::Unit::TestCase
  def test_assert_fail_fails_if_the_block_has_no_failed_assertions
    failed_assertion = false
    begin
      assert_fail do
      end
    rescue Test::Unit::AssertionFailedError => e
      failed_assertion = true
    end

    flunk("assert_fail incorrectly passed") unless failed_assertion
  end

  def test_assert_fail_succeeds_when_the_block_fails_an_assertion
    assert_fail do
      assert_equal 4, 5
    end
  end
end
