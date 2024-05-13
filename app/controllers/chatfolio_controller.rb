# This controls chatpholio app
class ChatfolioController < ApplicationController
  def index
  end

  def generate_response
    puts 'generate_response called'
    @question = params[:user_message]
    render json: { response: answer.dig('choices', 0, 'message', 'content') }
  end

  private

  def answer
    openai_client.chat(
      parameters: {
        model: 'gpt-3.5-turbo',
        messages: [{ role: 'user', content: message }],
        temperature: 0.7
      }
    )
  end

  def message
    <<-MESSAGE
      Answer the question based on the context below. Answer as if you are being interviewed.
      Answer in the same language used in the question. If the question can't be answered based on the context, say "I can't answer", "お答えできません" if Japanese, or "我不能回答" if Chinese.

      Context:
      #{context}

      ---

      Question: #{@question}
    MESSAGE
  end

  def context
    question_embedding = embedding_for(@question)
    nearest_items = Item.nearest_neighbors(
      :embedding, question_embedding,
      distance: 'euclidean'
    )
    nearest_items.first.text
  end

  def embedding_for(text)
    response = openai_client.embeddings(
      parameters: {
        model: 'text-embedding-3-small',
        input: text
      }
    )

    response.dig('data', 0, 'embedding')
  end

  def openai_client
    @openai_client ||= OpenAI::Client.new
  end
end
