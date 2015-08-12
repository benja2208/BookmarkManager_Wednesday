require 'sinatra/base'
require_relative '../data_mapper_setup'

class BookmarkManager < Sinatra::Base
  enable :sessions
  set :session_secret, 'super secret'

  helpers do 
    def current_user
      @current_user ||= User.get(session[:user_id]) if session[:user_id]
    end 
  end 

  get '/' do
    erb :welcome
  end

  get '/links' do
    @links = Link.all
    erb :'links/index'
  end

  get '/links/new' do
    erb :'links/new'
  end

  post '/links' do
    link = Link.new(url: params[:url], title: params[:title])
    params[:tag].empty? ? tag_array = ["Untagged"] : tag_array = params[:tag].split(', ')
    tag_array.each do |tag|
      new_tag = Tag.create(name: tag.capitalize)
      link.tags << new_tag
    end
    link.save
    redirect('/links')
  end

  get '/tags/:name' do
    tag = Tag.all(name: params[:name])
    @links = (tag ? tag.links : [])
    erb :'links/index'
  end

  get '/users/new' do 
    erb :'users/new'
  end 

  post '/users' do 
    user = User.create(email: params[:email],
                password: params[:password])
    session[:user_id] = user.id
    redirect to('/')
  end  

  # start the server if ruby file executed directly
  run! if app_file == $0
end
