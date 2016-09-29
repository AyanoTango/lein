# web通知の送信権をサーバーからリクエスト済みであることが前提
App.cable.subscriptions.create { channel: "ChatChannel", room: "room_id" },
#クライアントサイドの処理を行なうチャンネル、第二引数は何を指定すればいい？params[:id]?

  connected: ->
    # Called when the subscription is ready for use on the server

  disconnected: ->
    # Called when the subscription has been terminated by the server

  received: (data) ->　# メッセージを受け取ったら #comments に付け足す
    $('#comments').append data['comment']

  speak: (comment) ->#サーバサイドのチャンネルspeak にメッセージを送信する
    @perform 'speak', comment: comment



  # received: (data) -> # メッセージを受け取ったら #comments に付け足す
  #   @appendLine(data)
  #
  # appendLine: (data) ->
  #   html = @createLine(data)
  #   $("[data-chat-room='Best Room']").append(html)
  #
  # createLine: (data) ->
  #   """
  #   <article class="chat-line">
  #     <span class="speaker">#{data["sent_by"]}</span>
  #     <span class="body">#{data["body"]}</span>
  #   </article>
  #   """
