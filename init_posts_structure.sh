#!/bin/zsh
# ==============================================
# 🚀 init_posts_structure_zsh.sh
# 为 law888 博客自动创建 8 学科 + PDF + 其他 目录结构
# 每个文件夹带有 _index.md (标题、URL、描述、排序)
# 适用于 macOS 默认 zsh 环境
# ==============================================

set -e
cd "$(dirname "$0")"

echo "📁 创建 content/posts 目录..."
mkdir -p content/posts

# ---------- 学科标题 ----------
typeset -A titles
titles=(
  civil "民法 📘"
  criminal "刑法 ⚖️"
  admin "行政法 🏛️"
  civil-procedure "民诉法 🧾"
  criminal-procedure "刑诉法 🔍"
  commercial "商经知 💼"
  theory "理论法 📚"
  international "三国法 🌍"
  pdfs "PDF资料库 📂"
  others "其他内容 🪶"
)

# ---------- 学科简介 ----------
typeset -A descs
descs=(
  civil "民法总则、合同、侵权、物权笔记"
  criminal "刑法总论、分则、司法实务整理"
  admin "行政行为、行政复议、国家赔偿笔记"
  civil-procedure "证据制度、审判流程、程序要点"
  criminal-procedure "侦查起诉、审判程序与辩护要点"
  commercial "公司法、票据法、保险法、证券法"
  theory "宪法、法理学、社会法等理论基础"
  international "国际法、国际私法、国际经济法"
  pdfs "李建伟讲义、真题卷、历年参考资料"
  others "笔记、随想、临时记录"
)

# ---------- 排序 ----------
typeset -A weights
weights=(
  civil 1
  criminal 2
  admin 3
  civil-procedure 4
  criminal-procedure 5
  commercial 6
  theory 7
  international 8
  pdfs 9
  others 10
)

echo "🧩 创建各学科文件夹与 _index.md ..."

for dir in ${(k)titles}; do
  mkdir -p "content/posts/$dir"
  cat > "content/posts/$dir/_index.md" <<EOF
---
title: "${titles[$dir]}"
url: "/posts/$dir/"
date: $(date +%Y-%m-%d)
draft: false
hidemeta: true
weight: ${weights[$dir]}
description: "${descs[$dir]}"
---
EOF
  echo "✅ 已创建 content/posts/$dir/_index.md"
done

echo "✨ 创建 posts 总页 ..."
cat > content/posts/_index.md <<EOF
---
title: "法考笔记 📒"
date: $(date +%Y-%m-%d)
draft: false
hidemeta: true
description: "系统整理法考八大学科核心笔记与真题资料"
weight: 1
---
EOF

echo "🎉 所有目录已生成完毕!"
echo "👉 目录结构："
if command -v tree >/dev/null 2>&1; then
  tree content/posts
else
  ls -R content/posts
fi

echo
echo "🚀 下一步建议执行："
echo "hugo --minify"
echo "git add -A && git commit -m 'init: posts structure' && git push origin main"
