#!/usr/bin/env ruby
module Test
module Unit

#
# Some useful extra assertions.
# Require 'assertions', and Test::Unit::Assertions will have
# the additional assertions.
#
module Assertions
  public

  # 
  # ====Description:
  # This assertion passes if and only if block contains an assertion
  # that fails (but which is suppressed from propagating outside of
  # block and so will not cause the test to fail).
  # If the assertion passes, the failed assertion is written to
  # stdout.  This method is (only?) useful when testing other assertions.
  # 
  # ====Example:
  #  assert_fail do
  #    assert_equal(5, 4)
  #  end
  #
  # ====Parameters:
  # [message = ""]
  #      An optional additional message that will be displayed if the
  #      assertion fails.
  # [&block]
  #      This block should contain an assertion that fails.
  # 
  def assert_fail(message = "", &block)
    _wrap_assertion do
      full_message = build_message(message,
                                   "Failed assertion was expected, but it did not occur.")

      assert_block(full_message) do
        begin
          yield
          false
        rescue AssertionFailedError => e
          print("Assertion correctly failed:\n#{e.message}\n")
          true
        end
      end
    end
  end

  # 
  # ====Description:
  # This assertion passes if and only if boolean is false or nil.
  # 
  # ====Parameters:
  # [boolean]
  #      This must be false or nil or the assertion to pass
  # [message = ""]
  #      An optional additional message that will be displayed if the
  #      assertion fails.
  # 
  def assert_not(boolean, message = "")
    _wrap_assertion do
      full_message = build_message(message,
                                   "<?> incorrectly is true.",
                                   boolean)

      assert_block(full_message) do
        !boolean
      end
    end
  end

  #
  # ====Description:
  # This is a convenience wrapper around assert_operator.  It asserts that
  # the value is greater than zero
  #
  # ====Example:
  #  assert_positive(12)
  #
  # ====Parameters:
  # [value]
  #      The number whose positiveness we wish to determine
  # [message = ""]
  #      An optional additional message that will be displayed if the
  #      assertion fails.
  #
  def assert_positive(value, message = "")
    assert_operator(value, :>, 0, message)
  end

  #
  # ====Description:
  # This is a convenience wrapper around assert_operator.  It asserts that
  # the value is less than zero
  #
  # ====Example:
  #  assert_negative(-5)
  #
  # ====Parameters:
  # [value]
  #      The number whose negativeness we wish to determine
  # [message = ""]
  #      An optional additional message that will be displayed if the
  #      assertion fails.
  #
  def assert_negative(value, message = "")
    assert_operator(value, :<, 0, message)
  end

  # 
  # ====Description:
  # This is a convenience wrapper around assert_operator.  It asserts that
  # lhs > rhs.
  # 
  # ====Example:
  #  assert_greater_than(5, 4)
  #
  # ====Parameters:
  # [lhs]
  #      The left-hand side of the comparison.
  # [rhs]
  #      The right-hand side of the comparison.
  # [message = ""]
  #      An optional additional message that will be displayed if the
  #      assertion fails.
  # 
  def assert_greater_than(lhs, rhs, message = "")
    assert_operator(lhs, :>, rhs, message)
  end
  alias assert_gt assert_greater_than

  # 
  # ====Description:
  # This is a convenience wrapper around assert_operator.  It asserts that
  # lhs >= rhs.
  # 
  # ====Example:
  #  assert_greater_than_or_equal_to(5, 5)
  #
  # ====Parameters:
  # [lhs]
  #      The left-hand side of the comparison.
  # [rhs]
  #      The right-hand side of the comparison.
  # [message = ""]
  #      An optional additional message that will be displayed if the
  #      assertion fails.
  # 
  def assert_greater_than_or_equal_to(lhs, rhs, message = "")
    assert_operator(lhs, :>=, rhs, message)
  end
  alias assert_ge assert_greater_than_or_equal_to

  # 
  # ====Description:
  # Will tell you if the elements in an Enum are sorted (ascending)
  #
  # ====Example:
  #  assert_sorted([1,2,3,4])
  #
  # ====Parameters:
  # [enum]
  #      The enumeration to check for sortedness.
  # [message = ""]
  #      An optional additional message that will be displayed if the
  #      assertion fails.
  def assert_sorted(enum, message = "")
    raise ArgumentError.new("enum must be enumerable") unless enum.is_a?(Enumerable)
    assert_equal enum.clone.sort{|a,b| a <=> b }, enum
  end

  #
  # ====Description:
  # Will tell you if the elements in an Enum are sorted (ascending)
  #
  # ====Example:
  #  assert_sorted_desc([4,3,2,1])
  #
  # ====Parameters:
  # [enum]
  #      The enumeration to check for sortedness.
  # [message = ""]
  #      An optional additional message that will be displayed if the
  #      assertion fails.
  def assert_sorted_desc(enum, message = "")
    raise ArgumentError.new("enum must be enumerable") unless enum.is_a?(Enumerable)
    assert_equal enum.clone.sort{|a,b| b <=> a }, enum
  end


  private
  def check_enum_for_key_sortability(key, enum)
    raise ArgumentError.new("key must be symbol or string") unless (key.is_a?(String) || key.is_a?(Symbol))
    raise ArgumentError.new("enum must be enumerable") unless enum.is_a?(Enumerable)
    raise ArgumentError.new("enum's elements don't respond to the key") unless enum.all?{ |x| (x.is_a?(Hash) && x.has_key?(key)) || x.respond_to?(key) }    
  end

  public
  # 
  # ====Description:
  # Will tell you if the elements in an Enum are sorted (ascending)
  # based on a key corresponding to a key in a hash or method on a
  # class.
  #
  # ====Example:
  #  assert_sorted_by :bar, [{:bar => 1}, {:bar => 2}]
  #
  # ====Parameters:
  # [key]
  #      A string or symbol to use to get a value on an object in 'enum'
  # [enum]
  #      The enumeration to check for sortedness.
  # [message = ""]
  #      An optional additional message that will be displayed if the
  #      assertion fails.
  def assert_sorted_by(key, enum, message = "")
    check_enum_for_key_sortability(key, enum)
    assert_sorted enum.map{ |x| x.is_a?(Hash) ? x[key] : x.send(key) }
  end
  
  # 
  # ====Description:
  # Will tell you if the elements in an Enum are sorted (descending)
  # based on a key corresponding to a key in a hash or method on a
  # class.
  #
  # ====Example:
  #  assert_sorted_by_desc :bar, [{:bar => 2}, {:bar => 1}]
  #
  # ====Parameters:
  # [key]
  #      A string or symbol to use to get a value on an object in 'enum'
  # [enum]
  #      The enumeration to check for sortedness.
  # [message = ""]
  #      An optional additional message that will be displayed if the
  #      assertion fails.
  def assert_sorted_by_desc(key, enum, message = "")
    check_enum_for_key_sortability(key, enum)
    assert_sorted_desc enum.map{ |x| x.is_a?(Hash) ? x[key] : x.send(key) }
  end

  #
  # ====Description:
  # Find out if a something is between two other things when compared.
  # It asserts that lhs1 < rhs < lhs2 or lhs1 > rhs > lhs2
  #
  # ====Example:
  #  assert_between(Date.yesterday, Date.tomorrow, Date.today)
  #
  # ====Parameters:
  # [lhs1]
  #      One of the things to compare against
  # [lhs2]
  #      The other thing to compare against
  # [rhs]
  #      The thing being tested for between-ness
  # [message = ""]
  #      An optional additional message that will be displayed if the
  #      assertion fails.
  #
  def assert_between(lhs1, lhs2, rhs, message="")
    if lhs1 == lhs2
      full_message = build_message(message, "Gave the same value for both sides of range. <?> was not equal to <?>", rhs, lhs1)
      assert_block(full_message) { lhs1 == rhs }
    else
      lower  = lhs1 < lhs2 ? lhs1 : lhs2
      higher = lhs1 < lhs2 ? lhs2 : lhs1
      full_message = build_message(message, "<?> was not between <?> and <?>", rhs, lower, higher)
      assert_block(full_message) { lower < rhs && rhs < higher }
    end
  end
  
  #
  # ====Description:
  # This is a convenience wrapper around assert_operator.  It asserts that
  # lhs < rhs.
  # 
  # ====Example:
  #  assert_less_than(4, 5)
  #
  # ====Parameters:
  # [lhs]
  #      The left-hand side of the comparison.
  # [rhs]
  #      The right-hand side of the comparison.
  # [message = ""]
  #      An optional additional message that will be displayed if the
  #      assertion fails.
  # 
  def assert_less_than(lhs, rhs, message = "")\
    assert_operator(lhs, :<, rhs, message)
  end
  alias assert_lt assert_less_than

  # 
  # ====Description:
  # This is a convenience wrapper around assert_operator.  It asserts that
  # lhs <= rhs.
  # 
  # ====Example:
  #  assert_less_than_or_equal_to(4, 4)
  #
  # ====Parameters:
  # [lhs]
  #      The left-hand side of the comparison.
  # [rhs]
  #      The right-hand side of the comparison.
  # [message = ""]
  #      An optional additional message that will be displayed if the
  #      assertion fails.
  # 
  def assert_less_than_or_equal_to(lhs, rhs, message = "")
    assert_operator(lhs, :<=, rhs, message)
  end
  alias assert_le assert_less_than_or_equal_to

  # 
  # ====Description:
  # This assertion passes if and only if block throws an exception of
  # class (or descended from class) expected_exception_class with
  # message expected_exception_message.
  # 
  # ====Example:
  #  assert_raise_message("Hello, exception!", RuntimeError) do
  #    raise "Hello, exception!"
  #  end
  #
  # ====Parameters:
  # [expected_exception_message]
  #      The message expected to be contained in the exception thrown
  #      by block.
  # [expected_exception_class]
  #      The expected class (or parent class) of the exception thrown by
  #      block.
  # [message = ""]
  #      An optional additional message that will be displayed if the
  #      assertion fails.
  # [&block]
  #      The block that is supposed to throw the specified exception.
  #
  def assert_raise_message(expected_exception_message,
                           expected_exception_class,
                           message = "",
                           &block)
    _wrap_assertion do
      full_message = build_message(message,
                                   "<?> exception expected but none was thrown.",
                                   expected_exception_class)
      actual_exception = nil
      assert_block(full_message) do
        begin
          yield
          false
        rescue Exception => e
          actual_exception = e
          true
        end
      end

      full_message = build_message(message,
                                   "<?> exception expected but was\n?",
                                   expected_exception_class,
                                   actual_exception)

      assert_block(full_message) do
        actual_exception.is_a?(expected_exception_class)
      end

      full_message = build_message(message,
                                   "<?> exception message expected but was\n<?>",
                                   expected_exception_message,
                                   actual_exception.message)
      assert_block(full_message) do
        expected_exception_message == actual_exception.message
      end
    end
  end

end
end
end
