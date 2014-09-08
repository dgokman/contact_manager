require 'sinatra'
require 'sinatra/reloader'
require 'sinatra/activerecord'
require 'pry'

require_relative 'models/contact'


get '/' do
  @contacts_all = Contact.all
  @limit = 3
  if params[:page] == nil
    @contacts = Contact.limit(@limit)
    @next_page = 2
  else
    @contacts = Contact.limit(@limit).offset(@limit * (params[:page].to_i - 1))
    @next_page = params[:page].to_i + 1
    @prev_page = params[:page].to_i - 1
  end
  erb :index
end

get '/contacts/:id' do
  @contact = Contact.find(params[:id])
  erb :show
end


