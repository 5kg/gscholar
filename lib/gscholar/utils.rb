require 'gscholar/utils/fetcher'
require 'gscholar/utils/lazy_proxy'
require 'gscholar/utils/text_plain_parser'

module GScholar
  module Utils
    def self.fetch(url)
      @fetcher ||= Fetcher.new
      @fetcher.fetch(url)
    end

    def self.reset_fetcher
      @fetcher = nil
    end
  end
end
