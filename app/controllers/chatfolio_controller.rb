# This controls chatpholio app
class ChatfolioController < ApplicationController
  def index
  end

  def generate_response
    user_message = params[:user_message]

    response = OpenAI::Client.new.chat(
      parameters: {
        model: 'gpt-3.5-turbo',
        messages: [{ role: 'user', content: user_message }],
        temperature: 0.5
      }
    )
    render json: { response: response.dig('choices', 0, 'message', 'content') }
  end
end
