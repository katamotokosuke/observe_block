
class SlackMessageSendClient
  REQ_DOMAIN = 'https://slack.com'
  REQ_PATH = '/api/chat.postMessage'

  attr_accessor :response

  def initialize
    @client = Faraday.new REQ_DOMAIN


    super
  end

  def send_message(text)
    result = @client.post do |req|
      req.url REQ_PATH
      req.body = {
        "token" => ENV['SLACK_TOKEN'],
        "channel" => ENV['NOTIFY_CHANNEL'],
        "text" => text
      }
    end
    @response = JSON.parse(result.body)

    unless @response["ok"]
      # ログを出力
      p @response
      return false
    end
    true
  end
end
