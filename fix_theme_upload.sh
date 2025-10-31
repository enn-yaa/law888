#!/bin/bash
# ============================================
# 🚀 fix_theme_upload.sh
# 自动修复 PaperMod 主题未上传问题
# 作者: enn-yaa 专用
# ============================================

set -e

echo "🔍 检查当前路径..."
if [ ! -d "themes/PaperMod" ]; then
  echo "❌ 未找到 themes/PaperMod 文件夹，请先克隆主题："
  echo "git clone https://github.com/adityatelange/hugo-PaperMod.git themes/PaperMod"
  exit 1
fi

echo "🧹 删除旧的子模块记录（若存在）..."
rm -f .gitmodules || true
git rm -r --cached themes/PaperMod 2>/dev/null || true

echo "📦 重新添加 PaperMod 文件夹..."
git add themes/PaperMod

echo "🪄 提交更改..."
git commit -m "fix: add PaperMod theme folder properly" || echo "⚠️ 无需提交（可能已提交过）"

echo "☁️ 推送到 GitHub..."
git push origin main

echo "✅ 完成！请到 GitHub 检查是否能打开："
echo "👉 https://github.com/enn-yaa/law888/tree/main/themes/PaperMod"
echo
echo "如果能打开并看到 layouts/、assets/ 文件夹，就可以回到 Cloudflare Pages 点击 Retry Deployment"
