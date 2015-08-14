require_relative './base.rb'

module Armadillo 
  module Routes
    class Links < Base
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
    end 
  end 
end 