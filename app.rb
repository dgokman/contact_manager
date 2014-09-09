require 'sinatra'
require 'sinatra/reloader'
require 'sinatra/activerecord'
require 'pry'

require_relative 'models/contact'


get '/' do
  @contacts_all = Contact.all
  @limit = 3
  if params[:query] && params[:page].nil?
    @contacts = Contact.where("first_name = ? OR last_name = ?",
      params[:query].capitalize, params[:query].capitalize)
  elsif params[:query].nil? && params[:page].nil?
    @contacts = Contact.limit(@limit)
    @next_page = 2
  else
    @contacts = Contact.limit(@limit).offset(@limit * (params[:page].to_i - 1))
    @next_page = params[:page].to_i + 1
    @prev_page = params[:page].to_i - 1
  end
  erb :index
  #binding.pry
end

post '/' do
  contact = Contact.create(first_name: params[:first_name],
    last_name: params[:last_name], phone_number: params[:phone_number])
  contact.save
  redirect '/'
end

get '/contacts/:id' do
  @contact = Contact.find(params[:id])
  erb :show
end



