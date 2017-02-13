class BotController < ApplicationController

  skip_before_filter  :verify_authenticity_token


  def webhook
    if params['hub.verify_token'] == "whatev"
      render text: params['hub.challenge'] and return
    else
      render text: 'error' and return
    end
  end

  def receive_message
    if params[:entry]
      messaging_events = params[:entry][0][:messaging]
      messaging_events.each do |event|
        sender = event[:sender][:id]
        if (text = event[:message] && event[:message][:text])
          send_text_message(sender, "Hi there! You said: #{text}. The Bots")
        end
      end
    end
    render nothing: true
  end

private

  def send_text_message(sender, text)

    body = {
      recipient: {
        id: sender
      },
      message: {
        text: text
      }
    }.to_json

    response = HTTParty.post(
      "https://graph.facebook.com/v2.6/me/messages?access_token=EAAK0l8jrEeIBAAzysXwfiELoHrGjqJ5JqJjkRxu4JFZBY0dNzf5kVXch1R1M0ZB6u4YgnprFHlrZAzoir7cNT6cniwjTaiE4WE6vJrz5c2Tt5InuiWJHaS0QMoq7aonjkqfHmtDidZAaZC3F6LMgmOlfI7ZCByuUCZAyxrGnIqZArwZDZD",
      body: body,
      headers: { 'Content-Type' => 'application/json' }
    )

  end

end
