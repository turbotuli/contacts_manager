require 'sinatra'
require 'sinatra/reloader'
require "sinatra/activerecord"
require 'pry'

require_relative 'models/contact'
also_reload 'models/contact'

set :bind, '0.0.0.0'  # bind to all interfaces

get '/' do
  if params["page"].nil?
    offset = 0
    @next_page = 2
  else
    offset = (25 * params["page"].to_i)
    @next_page = params["page"].to_i + 1
    @previous_page = params["page"].to_i - 1
  end
  @contacts = Contact.limit(25).offset(offset)
  erb :index
end

get '/contacts/:id' do
  @contact = Contact.where(id: params["id"]).first
  erb :show
end

post '/contacts/:id' do
  contact = Contact.where(id: params["id"]).first
  contact.delete
  redirect '/'
end

get '/new' do
  erb :new
end

post '/new' do
  contact = Contact.create(first_name: params["first_name"], last_name: params["last_name"],
    phone_number: params["phone_number"])
  redirect '/'
end

post '/search' do
  binding.pry
end
