require_relative './base.rb'

module Armadillo
	module Routes
		class Welcome < Base
	    get '/' do
	      erb :welcome
	    end
	  end 
	end 
end 
