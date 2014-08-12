require 'socket'

TCPSocket.open("localhost", 3000) {|sock|
  p sock.peeraddr #=> ["AF_INET", 80, "carbon.ruby-lang.org", "221.186.184.68"]
  p sock.peeraddr(true)  #=> ["AF_INET", 80, "carbon.ruby-lang.org", "221.186.184.68"]
  p sock.peeraddr(false) #=> ["AF_INET", 80, "221.186.184.68", "221.186.184.68"]
  p sock.peeraddr(:hostname) #=> ["AF_INET", 80, "carbon.ruby-lang.org", "221.186.184.68"]
  p sock.peeraddr(:numeric)  #=> ["AF_INET", 80, "221.186.184.68", "221.186.184.68"]
  puts sock
}
