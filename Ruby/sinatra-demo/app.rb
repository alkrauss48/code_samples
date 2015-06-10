require 'sinatra'
require 'json'

get '/' do
  # "Hello World"
  # @comment = "Some Comment"
  # erb :index
  401
end

get '/json' do
  content_type :json
  { foo: "bar"}.to_json
end

post '/comments' do
  "A new comment!"
end

put "/comments/:id" do
  "Updating comment #{params[:id]}"
end

error 401 do
  "You haz error"
end
