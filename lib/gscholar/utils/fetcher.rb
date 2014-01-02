require 'mechanize'

module GScholar
  module Utils

    class Fetcher
      def initialize
        @cache = {}
        @agent = Mechanize.new
        @agent.pluggable_parser['text/plain'] = TextPlainParser
        # Without changing user-agent, google will not return utf-8 page
        @agent.user_agent_alias = 'Mac Safari'

        # hack to enable BibTeX download
        scisig = @agent.get('http://scholar.google.com/scholar_settings').
                   form_with(:action => "/scholar_setprefs").field_with(:name => 'scisig').value
        @agent.get("http://scholar.google.com/scholar_setprefs?scisig=#{scisig}&num=20&scis=yes&scisf=4&instq=&save=")
      end

      def fetch(url)
        @cache[url] ||= @agent.get(url)
      end
    end

  end
end
