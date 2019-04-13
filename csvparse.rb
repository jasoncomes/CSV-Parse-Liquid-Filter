# frozen_string_literal: true

# csvparse / https://github.com/jasoncomes/CSV-Parse-Liquid-Filter
# Parses CSV data into a JSON object or array of objects.
# {% assign data = datasrc | csvparse %}

require 'csv'
require 'em-http-request'

module CSVParse
  def csvparse(datasrc, options = '')
    # Return if no Data Src.
    return if datasrc.nil? || datasrc.empty?

    # Variables
    response = ''
    options  = options.to_s.split(',').collect { |x| x.strip || x }

    # HTTP request or local data
    if datasrc.start_with? 'http'

      # URL
      url = datasrc.gsub('&amp;', '&')

      # HTTP Request(EM HTTP Request)
      EventMachine.run do
        http = EventMachine::HttpRequest.new(url, connect_timeout: 5, inactivity_timeout: 10).get
        http.errback { response = false; EM.stop }
        http.callback do
          response = http.response.force_encoding 'UTF-8'
          EventMachine.stop
        end
      end

    else

      # Local Data
      response = datasrc

    end

    # Return if response error
    return if !response || response.empty?

    # Parse CSV
    csv = options.include?('headers_convert') ? CSV.parse(response, headers: true, header_converters: ->(h) { h&.strip&.downcase&.tr(' ', '_') }) : CSV.parse(response, headers: true)

    # Return if no csv results.
    return if csv.empty?

    # Build data into Object Hash or Array, convert `CSV::Row` to Hash
    if options.include?('array')
      data = []
      csv.each { |row| data << row.to_h }
    else
      data = {}
      csv.each { |row| data[row[0]] = row.to_h }
    end

    # Return
    data
  end
end

Liquid::Template.register_filter(CSVParse)
