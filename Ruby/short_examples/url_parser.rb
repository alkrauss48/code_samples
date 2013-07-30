# Aaron Krauss - Question 2
# Estimated time: 50 min
# Source: http://en.wikipedia.org/wiki/Uniform_resource_locator
# I know wikipedia's not the most scholastic source, but I just wanted to get
# an example of all the parts
# Command to run: ruby ques_2.rb

# Based on the following syntax:
# scheme://domain:port/path?query_string#fragment_id

class URLParser

  attr_accessor :url, :protocol, :hostname, :port, :path, :queries

  def initialize(string)
    @url      = string
    @queries  = {}
  end

  def parse
    parts = @url.split('/')
    @protocol = parts[0].split(':')[0] # => parts[1] will be empty, so we skip that
    @hostname = parts[2].split(':')[0]
    @port     = parts[2].split(':')[1].to_i

    # Since not every url has queries, let's validate for that
    if parts[3].include?('?')
      @path   = parts[3].split('?')[0]
      queries = parts[3].split('?')[1]
      unless queries.nil? || queries.empty?
        # split on '&' for multiple queries; otherwise force the array
        split_queries = queries.include?('&') ? queries.split('&') : [queries]
        split_queries.each do |query|
          key = query.split('=')[0]
          val = query.split('=')[1]
          @queries[key] = val
        end
      end
    else
      @path = parts[3]
      @queries["None"] = "No queries for this URL"
    end
  end

end

# Testing
parsers     = []
parsers[0]  = URLParser.new('https://test.com:80/wiki?x=John&y=Doe')
parsers[1]  = URLParser.new('https://test.com:80/wiki?')
parsers[2]  = URLParser.new('https://test.com:80/wiki')
parsers[3]  = URLParser.new('https://case.com:80/unit?foo=bar')

parsers.each do |parser|
  parser.parse
  puts <<-MSG
*******
Parser Results:

Url:      #{parser.url}
Protocol: #{parser.protocol}
Hostname: #{parser.hostname}
Port:     #{parser.port}
Path:     #{parser.path}
Queries:

#{parser.queries}

  MSG
end
