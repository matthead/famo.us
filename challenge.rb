#Challenge
require 'sinatra'
require 'json'
class Challenge
	def initialize
		@words = Array.new
	end
	def pushWordToBack(word)
		return @words.push(word)
	end
	def getLastWord
		return @words.pop
	end
end
challenge = Challenge.new
set :port,8080
set :environment, :production

post '/write' do
return_message = {} 
  jdata = JSON.parse(params[:data],:symbolize_names => true) 
  if jdata.has_key?(:text) 
    challenge.pushWordToBack(jdata[:text])
  else
    return_message[:status] = 'text was not found'
  end
  return_message.to_json 
end

get '/read' do
	return_message = {}
	return_message[:text]= challenge.getLastWord()
	return_message.to_json
end	
