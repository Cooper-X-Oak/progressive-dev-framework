# 快速部署指南

## 方法 1：GitHub Template（推荐）

1. 在 GitHub 仓库页面，点击 Settings
2. 勾选 "Template repository"
3. 创建新项目时，点击 "Use this template" 按钮

## 方法 2：使用部署脚本

### Windows

```bash
# 下载脚本
curl -O https://raw.githubusercontent.com/Cooper-X-Oak/progressive-dev-framework/main/scripts/deploy-new-project.bat

# 运行
deploy-new-project.bat my-new-project D:\projects
```

### Linux/Mac

```bash
# 下载脚本
curl -O https://raw.githubusercontent.com/Cooper-X-Oak/progressive-dev-framework/main/scripts/deploy-new-project.sh
chmod +x deploy-new-project.sh

# 运行
./deploy-new-project.sh my-new-project ~/projects
```

## 方法 3：手动克隆

```bash
# 克隆框架
git clone https://github.com/Cooper-X-Oak/progressive-dev-framework.git my-new-project

cd my-new-project

# 删除原有 git 历史
rm -rf .git

# 初始化新仓库
git init
git add .
git commit -m "Initial commit based on Progressive Dev Framework"
```

## 部署后的步骤

1. 修改 `CLAUDE.md` - 更新项目名称和说明
2. 修改 `README.md` - 写你的项目介绍
3. 开始在 `demo/` 目录验证想法
4. 使用 `/demo-design` 和 `/capture-pattern` Skills

## 一键命令（推荐）

```bash
# 一行命令完成部署（Linux/Mac）
curl -sSL https://raw.githubusercontent.com/Cooper-X-Oak/progressive-dev-framework/main/scripts/deploy-new-project.sh | bash -s my-project-name

# Windows PowerShell
iwr https://raw.githubusercontent.com/Cooper-X-Oak/progressive-dev-framework/main/scripts/deploy-new-project.bat -OutFile deploy.bat; .\deploy.bat my-project-name
```
