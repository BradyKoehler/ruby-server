require 'socket'

TCPSocket.open("localhost", 3000) {|s|
  s.send "GET /DanteFyre.txt HTTP/1.0\r\n\r\n", 0
  p s.read
}
