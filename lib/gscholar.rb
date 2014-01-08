require 'gscholar/utils'
require 'gscholar/citation'
require 'gscholar/paper'

module GScholar
  def self.reset
    Utils.reset_fetcher
  end
end
