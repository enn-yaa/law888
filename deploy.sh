#!/bin/bash
# ============================================================
# Hugo 博客一键部署脚本 (Enhanced Edition)
# 作者：xuufaa / enn-yaa
# 功能：
#  - 自动检测 Hugo 版本
#  - 自动清理缓存与旧构建文件
#  - 自动构建并检测错误
#  - 自动提交并推送至 GitHub (SSH)
#  - 避免手动输入密码（推荐使用 ssh-agent）
# ============================================================

set -e  # 若任一步失败，立即终止脚本

# 🧭 项目路径（可根据实际修改）
BLOG_DIR="${1:-$(pwd)}"

# ✅ 自动进入博客目录
cd "$BLOG_DIR" || { echo "❌ 找不到目录 $BLOG_DIR"; exit 1; }

# 🧹 清理缓存与旧文件
echo "🧹 清理 Hugo 缓存与旧构建..."
hugo mod clean >/dev/null 2>&1 || true
rm -rf public/ resources/ >/dev/null 2>&1 || true

# 🧱 检查 Hugo 是否可用
if ! command -v hugo &>/dev/null; then
  echo "❌ Hugo 未安装，请先运行：brew install hugo"
  exit 1
fi

# 📦 打印版本信息
echo "🧩 当前 Hugo 版本：$(hugo version | awk '{print $5}' | tr -d ',')"

# ⚙️ 构建博客
echo "🧱 开始构建 Hugo 博客..."
if ! hugo --cleanDestinationDir; then
  echo "❌ Hugo 构建失败，请检查日志！"
  exit 1
fi
echo "✅ 构建完成！"

# 🔍 检查是否有修改
echo "🔍 检查 Git 状态..."
if [[ -z $(git status --porcelain) ]]; then
  echo "✅ 没有检测到更改，无需提交。"
else
  echo "📝 检测到变更，准备提交..."

  git add .
  COMMIT_MSG="update: 自动部署于 $(date '+%Y-%m-%d %H:%M:%S')"
  git commit -m "$COMMIT_MSG"

  echo "🚀 推送到 GitHub..."
  git push origin main && echo "✅ 推送成功！"
fi

# 🌍 自动打开网站（可注释掉）
if command -v open &>/dev/null; then
  open "https://law888.xuufaa.com/"
fi

echo "🎉 部署完成：$(date '+%Y-%m-%d %H:%M:%S')"
echo "✅ 博客已成功更新到 GitHub Pages！"
