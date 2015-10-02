# vim:fileencoding=utf-8
require 'simplecov'

require 'chirp'

module Support
  INTEGRATION_SERVER_PORT = rand(30_000..31_000)

  def start_integration_server
    Thread.new do
      require 'socket'

      server = TCPServer.new('localhost', INTEGRATION_SERVER_PORT)
      loop do
        socket = server.accept
        _ = socket.gets
        response = "Ohai #{rand}\n"
        socket.print(
          [
            'HTTP/1.1 200 OK',
            'Content-Type: text/plain;charset=utf-8',
            "Content-Length: #{response.bytesize}",
            'Connection: close',
            '',
            response
          ].join("\r\n")
        )
        socket.close
      end
    end
  end

  module_function :start_integration_server
end

ENV['CHIRP_CPU_DIGITS'] = '1'
ENV['CHIRP_DISK_WRITES'] = '10'
ENV['CHIRP_MEMORY_GB_ALLOCATIONS'] = '0.1'
ENV['CHIRP_NETWORK_URLS'] = \
  "http://localhost:#{Support::INTEGRATION_SERVER_PORT}/"

RSpec.configure do |c|
  Support.start_integration_server if ENV['INTEGRATION_SPECS']
  c.filter_run_excluding(integration: true) unless ENV['INTEGRATION_SPECS']
end
