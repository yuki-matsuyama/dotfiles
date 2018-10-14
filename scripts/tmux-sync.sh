#!/bin/bash

if [ -n "$SESSION_NAME" ];then
  session=$SESSION_NAME
else
  session=multi-ssh-`date +%s`
fi
window=multi-ssh

### tmuxのセッションを作成
tmux new-session -d -n $window -s $session

### 各ホストにsshログイン
# 最初の1台はsshするだけ
tmux send-keys "cd /Users/yukimatsuyama/workspace/residential_map/residential_map_web && git status && npm run dev" C-m
shift

# 残りはpaneを作成してからssh
tmux split-window
tmux select-layout tiled
tmux send-keys "cd /Users/yukimatsuyama/workspace/residential_map/residential_map_cloud_functions && git status" C-m

tmux split-window
tmux select-layout tiled
tmux send-keys "cd /Users/yukimatsuyama/workspace/residential_map/residential_map_batch && make cloud-sql-psql" C-m

tmux split-window
tmux select-layout tiled
tmux send-keys "cd /Users/yukimatsuyama/workspace/residential_map/residential_map_batch && git status && source env/bin/activate && python manage.py runserver" C-m

tmux split-window
tmux select-layout tiled
tmux send-keys "cd /Users/yukimatsuyama/workspace/residential_map/residential_map_spatial_analytics && git status" C-m

tmux split-window
tmux select-layout tiled
tmux send-keys "cd /Users/yukimatsuyama/workspace/go/src/residential_map_api && git status && make gin-run" C-m

### 最初のpaneを選択状態にする
tmux select-pane -t 0


### セッションにアタッチ
tmux attach-session -t $session
