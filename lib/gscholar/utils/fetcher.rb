require 'mechanize'

module GScholar
  module Utils

    module Fetcher
      @@cache = {}
      @@agent = Mechanize.new

      # hack
      scisig = @@agent.get('http://scholar.google.com/scholar_settings').form_with(:action => "/scholar_setprefs").field_with(:name => 'scisig').value
      @@agent.get("http://scholar.google.com/scholar_setprefs?scisig=#{scisig}&num=20&scis=yes&scisf=4&instq=&save=")

      def fetch(url)
        @@cache[url] ||= @@agent.get(url)
      end
    end

  end
end
