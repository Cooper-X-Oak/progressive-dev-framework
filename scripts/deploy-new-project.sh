#!/bin/bash
# Progressive Dev Framework - 快速部署脚本

if [ -z "$1" ]; then
    echo "用法: bash <(curl -sSL https://raw.githubusercontent.com/Cooper-X-Oak/progressive-dev-framework/main/scripts/deploy-new-project.sh) <项目名称> [目标目录]"
    echo "示例: bash <(curl -sSL https://raw.githubusercontent.com/Cooper-X-Oak/progressive-dev-framework/main/scripts/deploy-new-project.sh) my-project"
    exit 1
fi

PROJECT_NAME=$1
TARGET_DIR=${2:-.}
PROJECT_PATH="$TARGET_DIR/$PROJECT_NAME"

echo "🚀 开始部署 Progressive Dev Framework..."
echo "📁 项目名称: $PROJECT_NAME"
echo "📂 目标路径: $PROJECT_PATH"

# 克隆框架
git clone --depth 1 https://github.com/Cooper-X-Oak/progressive-dev-framework.git "$PROJECT_PATH" 2>/dev/null

cd "$PROJECT_PATH"

# 删除原有 git 历史
rm -rf .git

# 清理框架相关的文件（新项目不需要）
rm -rf scripts/
rm -f docs/project-history.md docs/setup-complete.md docs/summary.md docs/release-checklist.md docs/quick-deploy.md
rm -f demo/hello-htmler.html

# 初始化新的 git 仓库
git init -q
git add .
git commit -q -m "Initial commit based on Progressive Dev Framework"

echo ""
echo "✅ 部署完成！"
echo ""
echo "下一步："
echo "  cd $PROJECT_PATH"
echo "  # 修改 CLAUDE.md 和 README.md 为你的项目信息"
echo "  # 开始在 demo/ 目录验证你的想法"
echo ""
echo "可用的 Skills:"
echo "  /demo-design  - 设计 demo 功能"
echo "  /capture-pattern - 沉淀可复用模式"
