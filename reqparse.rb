module Reqparse
	
	class Request
		
		attr_accessor :arr
		
		def initialize(req)
			@arr = req.split(" ")
		end
	end
end