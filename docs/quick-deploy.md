# 快速部署指南

## 一行命令部署（推荐）

### Linux/Mac

```bash
bash <(curl -sSL https://raw.githubusercontent.com/Cooper-X-Oak/progressive-dev-framework/main/scripts/deploy-new-project.sh) my-project-name
```

### Windows PowerShell

```powershell
irm https://raw.githubusercontent.com/Cooper-X-Oak/progressive-dev-framework/main/scripts/deploy-new-project.ps1 | iex
```

运行后会提示输入项目名称。

或者直接指定项目名称：

```powershell
$ProjectName="my-project"; irm https://raw.githubusercontent.com/Cooper-X-Oak/progressive-dev-framework/main/scripts/deploy-new-project.ps1 | iex
```

### Windows CMD

CMD 不支持直接执行远程脚本，建议使用 PowerShell 或 Git Bash。

## 方法 1：GitHub Template

1. 在 GitHub 仓库页面，点击 Settings
2. 勾选 "Template repository"
3. 创建新项目时，点击 "Use this template" 按钮

## 方法 2：手动克隆

```bash
# 克隆框架
git clone --depth 1 https://github.com/Cooper-X-Oak/progressive-dev-framework.git my-new-project

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
