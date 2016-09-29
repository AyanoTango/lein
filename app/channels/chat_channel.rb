class ChatChannel < ApplicationCable::Channel
  # コンシューマーがこのチャネルのサブスクライバになると
  # このコードが呼び出される
  def subscribed
    stream_for "chat_#{params[:room]}"
  end


  def receive(data)
    ChatChannel.broadcast_to("chat_#{params[:room]}", data)
    puts("********")
    puts("********")
    # ChatChannel.broadcast_to(post, data)
  end

  def create(data)
    puts("********")
    puts(data)
    puts("********")
    # Commentsにデータを保存する

  end
end
