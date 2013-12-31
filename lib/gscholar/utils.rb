require 'gscholar/utils/fetcher'
require 'gscholar/utils/lazy_proxy'

module GScholar
  module Utils
    def self.fetch(url)
      @fetcher ||= Fetcher.new
      @fetcher.fetch(url)
    end
  end
end
