require 'bibtex'

module GScholar

  module Citeable
    def self.included(base)
      base.class_exec do
        def __bib
          @__bib ||= BibTeX.parse(bibtex.to_s).first
        end
      end
    end

    def citation(style)
      CiteProc.process __bib.to_citeproc, :style => style
    end

    def title
      __bib.title.to_s
    end

    def author
      __bib.author.map(&:to_s)
    end

    def year
      __bib.year.to_i
    end
  end

  class Citation
    include Citeable

    attr_reader :id, :bibtex
    alias_method :to_s, :bibtex

    def initialize(id)
      @id = id
      @bibtex = Utils::LazyProxy.new { Utils.fetch(bibtex_url).body }
    end

    private
    def bibtex_url
      "http://scholar.google.com/scholar.bib?q=info:#{@id}:scholar.google.com/&output=citation"
    end
  end

end
