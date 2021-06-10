require 'faraday'
require 'json'

class ChainInfoClient
  REQ_DOMAIN = 'http://localhost:8332'
  REQ_PATH = '/rest/chaininfo.json'

  attr_accessor :response

  def initialize
    @client = Faraday.new REQ_DOMAIN
    super
  end

  def get_count
    fetch['headers']
  end

  private

  def fetch
    response = @client.get REQ_PATH
    @response ||= JSON.parse response.body
  end
end
