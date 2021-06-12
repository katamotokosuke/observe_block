require 'dotenv'
require './client/BlockCountFromExplorerClient.rb'
require './client/ChainInfoClient.rb'
require './client/SlackMessageSendClient.rb'

def create_notify_message(chain_info_text)
  "Explorerとnodeに差分が生じました \n" +
  "chaininfoはこちら: \n" + chain_info_text
end

def bootstrap
  Dotenv.load
end

# 実行手順
# 1. explorerと自分で立てたnodeからblock number取得
# 2. 1の結果を嫁ごう
# 3. 一定条件下でSlack通知
bootstrap
NOTICE_DIFF_COUNT = 3

explorer_client = BlockCountFromExplorerClient.new
chain_info = ChainInfoClient.new
block_count_from_explorer = explorer_client.get_count
block_count_from_node = chain_info.get_count

# if (block_count_from_explorer - block_count_from_node).abs >= NOTICE_DIFF_COUNT
if true
  slack_client = SlackMessageSendClient.new
  slack_client.send_message(create_notify_message chain_info.get_dump)
end

exit