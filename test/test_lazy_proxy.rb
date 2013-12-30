require 'helper'
require 'gscholar/utils/lazy_proxy'

class LazyString
  def initialize(&block)
    @str = GScholar::Utils::LazyProxy.new &block
  end

  def split(*args, &block)
    @str.send :split, *args, &block
  end

  def gsub(*args, &block)
    @str.send :gsub, *args, &block
  end
end

class TestLazyProxy < Test::Unit::TestCase
  should "successfully initialize object lazily" do
   obj = nil

   assert_nothing_raised { obj = LazyString.new { raise "Lazy object initialized" } }
   assert_not_nil(obj)
   # wait for ruby 2.1 release
   #assert_raise_with_message(RuntimeError, "Lazy object initialized") { obj.foo }
   assert_raise(RuntimeError) { obj.split }
  end

  should "successfully delegate method call" do
   obj = LazyString.new { "a simple string" }
   assert_equal(obj.split.length, 3)
   assert_equal(obj.gsub("simple ", ""), "a string")
   assert_equal(obj.gsub("simple") {|match| match.upcase }, "a SIMPLE string")
  end
end
