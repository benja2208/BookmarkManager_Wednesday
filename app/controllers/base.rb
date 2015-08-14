require './data_mapper_setup.rb'
require 'sinatra/partial'

module Armadillo
	module Routes
		class Base < Sinatra::Base
			  enable :sessions
		    
		    register Sinatra::Flash
		    register Sinatra::Partial

		    set :session_secret, 'super secret'

		    use Rack::MethodOverride

		    set :views,proc {File.join(root, '..', 'views')}
		    set :partial_template_engine, :erb

    helpers do 
      def current_user
        @current_user ||= User.get(session[:user_id]) if session[:user_id]
      end 
    end

		end 
	end 
end 