



= assertions
* Project Page: http://rubyforge.org/projects/assertions/

== DESCRIPTION:
This package adds some additional assertions to Test::Unit::Assertions,
including:
* Assertions for all of the comparison operators
  (Test::Unit::Assertions#assert_greater_than,
  Test::Unit::Assertions#assert_less_than_or_equal_to,
  etc.).  Shorter aliases also are provided for these
  (Test::Unit::Assertions#assert_gt, Test::Unit::Assertions#assert_le, etc.).
* An assertion that verifies that a given block raises a specified exception
  with a specified message (Test::Unit::Assertions#assert_raise_message).
  This allows full testing of error messages.
* An assertion that verifies that a given block contains an assertion that
  fails (Test::Unit::Assertions#assert_fail), which can be used to test new
  assertions.
* An assertion that verifies that a given value is false or nil
  (Test::Unit::Assertions#assert_not)
* Assertions that verify enumerables are sorted
  (Test::Unit::Assertions#assert_sorted, Test::Unit::Assertions#assert_sorted_desc,
  Test::Unit::Assertions#assert_sorted_by, Test::Unit::Assertions#assert_sorted_by_desc)

== PROBLEMS:
None (known).

== SYNOPSIS:
======<tt>examples/example.rb</tt>:
 #!/usr/bin/env ruby
 require 'rubygems'
 require 'assertions'
 
 require 'test/unit'
 
 class Tests < Test::Unit::TestCase
   def test_assertions
     #
     # Verify that 4 > 5 is false.
     #
     assert_not(4 > 5)
 
     #
     # Verify that 4 < 5
     #
     assert_less_than(4, 5)
     
     #
     # Verify that 4 < 5 again, but this time with the
     # shorter alias.
     #
     assert_lt(4, 5)
     
     #
     # Verify that 5 >= 5
     #
     assert_ge(5, 5)
     
     #
     # Verify that the specified exception is raised.
     #
     assert_raise_message("Hello, exception!", RuntimeError) do
       raise "Hello, exception!"
     end
     
     #
     # Verify that an assertion failed.
     #
     assert_fail do
       assert_equal(5, 4)
     end

     #
     # Verify an enumerable is sorted
     #
     assert_sorted([1,2,3])

     #
     # Verify an enumerable is sorted descending
     #
     assert_sorted_desc([3,2,1])

     #
     # Verify an enumerable is sorted based on a key
     #
     assert_sorted_by(:key, [{:key => 1}, {:key => 2}])

     #
     # Verify an enumerable is sorted descending based on a key
     #
     assert_sorted_by(:key, [{:key => 2}, {:key => 1}])
   end
 end


== REQUIREMENTS:
Hoe is required but only for running the tests.

== INSTALL:
 sudo gem install assertions

== AUTHORS:
=== Designing Patterns
* Homepage: http://www.designingpatterns.com
* Blogs: http://blogs.designingpatterns.com
=== Expected Behavior
* Homepage: http://www.expectedbehavior.com/blog

== SUPPORT:
Please post questions, concerns, or requests for enhancement to the forums on
the project page.  Alternatively, direct contact information for
Designing Patterns can be found on the project page for this gem.

== ENHANCEMENTS:
Please feel free to contact us with any ideas; we will try our best to
enhance the software and respond to user requests.  Of course, we are more
likely to work on a particular enhancement if we know that there are users
who want it.  Designing Patterns provides contracting and consulting services,
so if there is an enhancement that *must* get done (and in a specified time
frame), please inquire about retaining our services!

== LICENSE:
The license text can be found in the +LICENSE+ file at the root of the
distribution.

This  package is licensed with an MIT license:

Copyright (c) 2008-2009 Designing Patterns

Permission is hereby granted, free of charge, to any person obtaining
a copy of this software and associated documentation files (the
'Software'), to deal in the Software without restriction, including
without limitation the rights to use, copy, modify, merge, publish,
distribute, sublicense, and/or sell copies of the Software, and to
permit persons to whom the Software is furnished to do so, subject to
the following conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED 'AS IS', WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

== SHARE AND ENJOY!

