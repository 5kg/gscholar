require 'helper'

class TestFetcher < Test::Unit::TestCase
  should "successfully fetch 'http://scholar.google.com/'" do
    page = GScholar::Utils.fetch('http://scholar.google.com/')
    assert_not_nil page
    assert_equal "200", page.code
    assert_equal "Google Scholar", page.title
  end

  should "successfully set cookie" do
    GScholar::Utils.fetch('http://scholar.google.com/')
    page = GScholar::Utils.fetch('http://scholar.google.com/scholar_settings')
    assert_not_nil page

    # When in absence of cookies, the response should contains a '.gs_alrt' div
    # with "Your cookies seem to be disabled." warning inside.
    assert page.search('.gs_alrt').empty?
  end

  should "use cached page when refetch a url" do
    id = GScholar::Utils.fetch('http://scholar.google.com/').__id__
    assert_equal id, GScholar::Utils.fetch('http://scholar.google.com/').__id__
  end
end
