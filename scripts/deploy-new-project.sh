#!/bin/bash
# Progressive Dev Framework - 快速部署脚本

if [ -z "$1" ]; then
    echo "用法: ./deploy-new-project.sh <项目名称> [目标目录]"
    echo "示例: ./deploy-new-project.sh my-new-project ~/projects"
    exit 1
fi

PROJECT_NAME=$1
TARGET_DIR=${2:-.}
PROJECT_PATH="$TARGET_DIR/$PROJECT_NAME"

echo "🚀 开始部署 Progressive Dev Framework..."
echo "📁 项目名称: $PROJECT_NAME"
echo "📂 目标路径: $PROJECT_PATH"

# 克隆框架
git clone https://github.com/Cooper-X-Oak/progressive-dev-framework.git "$PROJECT_PATH"

cd "$PROJECT_PATH"

# 删除原有 git 历史
rm -rf .git

# 初始化新的 git 仓库
git init
git add .
git commit -m "Initial commit based on Progressive Dev Framework"

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
