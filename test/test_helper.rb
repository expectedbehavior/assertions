$LOAD_PATH.push(File.expand_path "../../test", __FILE__)
require "test/unit"
require "assertions"

# 1.9 compatibility patch for test/unit
module Test
  module Unit
    if defined?(MiniTest) && !defined?(AssertionFailedError)
      AssertionFailedError = MiniTest::Assertion
    end
  end
end
