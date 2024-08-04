require 'uri'
require 'net/http'
require 'json'
require 'dotenv/load'
Dotenv.load
# PROJECT_ID = "qwiklabs-gcp-00-88e7ae383591"
# LOCATION = "us-central1"
# MODEL_ID = "gemini-1.0-pro"
API_KEY = ENV['GOOGLE_API_KEY_FILE']

# enable generative language API
# https://console.developers.google.com/apis/api/generativelanguage.googleapis.com

# uri_string = "https://#{LOCATION}/v1/projects/#{PROJECT_ID}/locations/#{LOCATION}/publishers/google/models/#{MODEL_ID}:streamGenerateContent?key=#{API_KEY}"
uri_string = "https://generativelanguage.googleapis.com/v1/models/gemini-pro:generateContent?key=#{API_KEY}"

req_uri = URI(uri_string)

body_request = {
  'contents' => {
    'role' => 'USER',
    'parts' => { 'text' => 'Why is the sky blue?' }
  }
}.to_json

res = Net::HTTP.post req_uri, body_request, 'Content-Type' => 'application/json'
# puts res.body
response_data = JSON.parse(res.body)
# puts response_data
puts response_data['candidates'][0]['content']['parts'][0]['text']
