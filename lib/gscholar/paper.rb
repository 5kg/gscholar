require 'bibtex'

module GScholar
  class Paper
    include GScholar::Citeable

    attr_reader :id, :bibtex
    alias_method :to_s, :bibtex

    CITATION_PER_PAGE = 20

    def initialize(id)
      @id = id
      @bibtex = Utils::LazyProxy.new { Utils.fetch(bibtex_url).body }
    end

    def cited
      @cited ||= Utils.fetch(cluster_url).body[/>Cited by (\d+)<\/a>/, 1].to_i
    end

    def citations(range = nil)
      rst = []
      rst += Utils.fetch(citations_url(rst.size)).links_with(:text => "Related articles").
               map {|link| Citation.new(link.href[/related:([^:]+):/, 1]) } until rst.size == cited
      rst
    end

    private
    def bibtex_url
      "http://scholar.google.com/scholar.bib?q=info:#{key}:scholar.google.com/&output=citation"
    end

    def cluster_url
      "http://scholar.google.com/scholar?cluster=#{@id}"
    end

    def citations_url(start = 0)
      "http://scholar.google.com/scholar?cites=#{@id}&num=20&start=#{start}"
    end

    def key
      @key ||= Utils.fetch(cluster_url).link_with(:text => "Related articles").href[/related:([^:]+):/, 1]
    end
  end
end
