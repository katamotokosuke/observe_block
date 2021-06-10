require './client/BlockCountFromExplorerClient.rb'
require './client/ChainInfoClient.rb'

# 実行手順
# 1. explorerと自分で立てたnodeからblock number取得
# 2. 1の結果を嫁ごう
# 3. 一定条件下でSlack通知
NOTICE_DIFF_COUNT = 3

explorer_client = BlockCountFromExplorerClient.new
chain_info = ChainInfoClient.new
block_count_from_explorer = explorer_client.get_count
block_count_from_node = chain_info.get_count

if (block_count_from_explorer - block_count_from_node).abs >= NOTICE_DIFF_COUNT
  # slack通知
end

exit