#!/bin/bash

input=$(cat)

# モデル名
model=$(echo "$input" | jq -r '.model.display_name')

# コンテキスト使用量（%）
usage=$(echo "$input" | jq '.context_window.current_usage')
if [ "$usage" != "null" ]; then
  current=$(echo "$usage" | jq '.input_tokens + .cache_creation_input_tokens + .cache_read_input_tokens')
  size=$(echo "$input" | jq '.context_window.context_window_size')
  pct=$((current * 100 / size))
  context_info="context:${pct}%"
else
  context_info="context:0%"
fi

# カレントディレクトリ
cwd=$(echo "$input" | jq -r '.workspace.current_dir')

# Gitリポジトリ名とブランチ（色付き）
if [ -d "$cwd/.git" ] || git -C "$cwd" rev-parse --git-dir > /dev/null 2>&1; then
  cd "$cwd"
  repo_name=$(basename "$(git rev-parse --show-toplevel 2>/dev/null)")
  branch_name=$(git rev-parse --abbrev-ref HEAD 2>/dev/null)

  if git diff --quiet 2>/dev/null && git diff --cached --quiet 2>/dev/null; then
    # クリーン - 緑
    git_info=$(printf '\033[32m%s(%s)\033[0m' "$repo_name" "$branch_name")
  else
    # 変更あり - 赤
    git_info=$(printf '\033[31m%s(%s)\033[0m' "$repo_name" "$branch_name")
  fi
else
  git_info=""
fi

# 出力
if [ -n "$git_info" ]; then
  printf '%s | %s %s' "$model" "$context_info" "$git_info"
else
  printf '%s | %s' "$model" "$context_info"
fi
