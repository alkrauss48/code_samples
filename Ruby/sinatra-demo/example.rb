require 'sinatra'
require 'json'

get '/' do
  # @comment = "This is a comment"
  # erb :index
  401
end

get '/json' do
  content_type :json
  { 'foo' => 'baz' }.to_json
end

post '/comment' do
  "This would post a new comment"
end

put '/comment/:id' do
  "Updating comment: #{params[:id]}"
end

error 401 do
  "You haz error"
end
