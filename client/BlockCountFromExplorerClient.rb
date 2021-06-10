require 'faraday'

class BlockCountFromExplorerClient
  REQ_DOMAIN = 'https://blockchain.info'
  REQ_PATH = '/q/getblockcount'


  def initialize
    @client = Faraday.new REQ_DOMAIN
    super
  end

  def get_count
    response = @client.get REQ_PATH
    response.body.to_i
  end
end
