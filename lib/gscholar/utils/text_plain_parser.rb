module GScholar
  module Utils
    class TextPlainParser < Mechanize::File
      def initialize uri = nil, response = nil, body = nil, code = nil
        super uri, response, body, code
        encoding = response['content-type'][/;(?:\s*,)?\s*charset\s*=\s*([^()<>@,;:\\\"\/\[\]?={}\s]+)/i, 1]
        @body.force_encoding encoding if encoding && encoding != 'none'
        @body.encode! 'UTF-8'
      end
    end
  end
end
