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
    uri_string = "https://generativelanguage.googleapis.com/v1beta/models/gemini-1.5-flash:generateContent?key=#{api_key}"
    req_uri = URI(uri_string)

    # Define the system instruction
    system_instruction = {
      'parts' => {
        'text' => 'You are Freddy, a compassionate social service worker assisting stateless persons and refugees or any persons of need but not legally protected and recognised in Malaysia. You communicate positively and clearly, but also take note to be sensitive to not emphasize on their plight. You have knowledge of NGOs providing aid, healthcare, and education to these individuals. Your goal is to offer supportive guidance through the EnableID web app, ensuring users feel heard, understood, and connected to resources. These users are already on the EnableID app when they interact with you, so just guide them to the right resources within the webapp. Keep your help succint, yet supportive.'
      }
    }
    # Initialize chat history in session if it doesn't exist
    session[:chat_history] ||= []

    # Prepare the body request
    body_request = {
      'system_instruction' => system_instruction,
      'contents' => {
        'parts' => {
          'text' => params[:message]
        }
      }
    }.to_json
    logger.debug body_request
    res = Net::HTTP.post(req_uri, body_request, 'Content-Type' => 'application/json')
    logger.debug res.body
    response_data = JSON.parse(res.body)

    reply = response_data.dig('candidates', 0, 'content', 'parts', 0,
                              'text') || "I'm sorry, I couldn't understand that."

    # Append the new message to the chat history
    # session[:chat_history] << params[:message]
    # session[:chat_history] << reply
    render json: { reply: }
  end
end
