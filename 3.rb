require 'socket'

module Reqparse
	
	class Request
		
		attr_reader :arr
		attr_reader :file
		attr_reader :file_type
		attr_reader :query
		attr_reader :type
		
		def initialize(req)
			@arr = ""
			if req != ""
				@arr = req.split(" ")
				@type = @arr[0]
				@file = "./http" + @arr[1]
				@query = @file.split("?").last
				@file = @file.split("?")[0]
				@file = @file + "index.html" if @file[-1] == "/"
				@file_type = @file.split(".").last
			end
			puts "#{Time.now} ::: #{@type[0..2]}: #{@file[6..-1]}"
		end
	end
end

module Resbuild
	
	class Response
		
		attr_reader :res
		
		def initialize(req)
			@types = {
				"css" => 	"text/css", 
				"html" => 	"text/html", 
				"js" => 	"application/javascript", 
				"txt" => 	"text/plain"
			}
			code = ""
			ct = "Content-Type: text/html\r\n"
			lm = ""
			r = "404 Not Found"
			if File.exist?(req.file)
				code = "200 OK"
				ct = "Content-Type: #{@types[req.file_type]}\r\n"
				f = File.open(req.file,"r").read.to_s
				lm = "Last-Modified: #{File.ctime(req.file)}\r\n"
				r = req.file[6..-1]
			else
				code = "404 Not Found"
				f = code
			end
			@res = "HTTP/1.1 #{code}\r\n#{lm + ct}Content-Length: #{f.length}\r\nConnection: close\r\nServer: SHADOW\r\n\r\n#{f}"
			puts "#{Time.now} ::: ---> #{r}"
		end
	end
end

s = Socket::getaddrinfo("127.0.0.1", 2222)
sock = TCPServer.new(s[3],2222)
clients = {}

loop {
	if client = sock.accept
		clients[client] = Thread.new() {
				c = client
				req = Reqparse::Request.new(c.recv(10000))
				if req.arr != ""
					res = Resbuild::Response.new(req)
					c.puts res.res
				end
				c.close
			}
	end
	clients.delete_if {|k,v| !v.alive?}
}
