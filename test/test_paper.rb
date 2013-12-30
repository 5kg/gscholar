require 'helper'

# Helmer, Scott, et al. Curious george: The ubc semantic robot vision system. Vol. 2. Technical Report AAAI-WS-08-XX, AAAI Technical Report Series, 2007.
PAPER_0 = '8322442812667615406'
# Maxwell, Bruce A., Brian M. Leighton, and Leah R. Perlmutter. "A Responsive Vision System to Support Human-Robot Interaction."
PAPER_1 = '778988983414467064'

class TestPaper < Test::Unit::TestCase
  def setup
    @p0, @p1 = GScholar::Paper.new(PAPER_0), GScholar::Paper.new(PAPER_1)
  end

  should "successfully get number of citation" do
    assert_equal(@p0.cited, 1)
    assert_equal(@p1.cited, 0)
  end

  should "successfully get paper information" do
    assert_equal(@p0.title, "Curious george: The ubc semantic robot vision system")

    assert_equal(@p0.year, 2007)

    author = @p1.author
    assert_equal(author.length, 3)
    assert_equal(author[0], "Maxwell, Bruce A")

    assert_not_nil(@p1.to_s['maxwellresponsive'])
  end

  should "successfully get paper citations" do
    c0 = @p0.citations
    assert_equal(c0.size, 1)
    assert_equal(c0.first.title, "A Responsive Vision System to Support Human-Robot Interaction")

    c1 = @p1.citations
    assert_equal(c1.size, 0)
  end
end
