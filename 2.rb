require 'socket'

s = Socket.new(:INET, :STREAM, 0)
s.bind(Addrinfo.tcp("127.0.0.1", 2222))
p s.local_address
while true
	if c = s.accept
		#client_socket, client_addrinfo = s.accept
		#puts "client connected"
		#s.send("hello",1)
		#client_socket.puts "Hello"
		puts "client connected"
		c.send("Hello", 0)
		c.close
	end
end