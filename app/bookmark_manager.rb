require 'sinatra/base'
require 'sinatra/flash'
require_relative '../data_mapper_setup'
require 'sinatra/partial'

require_relative './controllers/base'
require_relative './controllers/welcome'
require_relative './controllers/link'
require_relative './controllers/user'
require_relative './controllers/session'


module Armadillo
  class BookmarkManager < Sinatra::Base

    use Routes::Welcome
    use Routes::Links
    use Routes::Users
    use Routes::Sessions
   

    # start the server if ruby file executed directly
    run! if app_file == $0
  end
end