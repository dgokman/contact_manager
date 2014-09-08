require 'sinatra'
require 'sinatra/reloader'
require 'sinatra/activerecord'
require 'pry'

require_relative 'models/contact'


get '/' do
  # @contacts = Contact.all
  if params[:page] == nil
    @contacts = Contact.limit(3)
    @next_page = 2
  else
    @contacts = Contact.limit(3).offset(3 * (params[:page].to_i - 1))
    @next_page = params[:page].to_i + 1
  end
  erb :index
end

get '/contacts/:id' do
  @contact = Contact.find(params[:id])
  erb :show
end


