class ChatbotController < ApplicationController
  require 'uri'
  require 'net/http'
  require 'json'
  require 'dotenv/load'
  Dotenv.load

  skip_before_action :verify_authenticity_token

  def new
  end

  def chat
    api_key = ENV['GOOGLE_API_KEY_FILE']
    uri_string = "https://generativelanguage.googleapis.com/v1/models/gemini-pro:generateContent?key=#{api_key}"
    req_uri = URI(uri_string)

    body_request = {
      'contents' => {
        'role' => 'USER',
        'parts' => { 'text' => params[:message] }
      }
    }.to_json

    res = Net::HTTP.post(req_uri, body_request, 'Content-Type' => 'application/json')
    response_data = JSON.parse(res.body)

    reply = response_data.dig('candidates', 0, 'content', 'parts', 0,
                              'text') || "I'm sorry, I couldn't understand that."

    render json: { reply: }
  end
end
