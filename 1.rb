require 'WEBrick'

server = WEBrick::HTTPServer.new(:BindAddress => "localhost", :Port => 2000, :DocumentRoot => "./http/")
begin
	server.start
ensure
	server.shutdown
end
