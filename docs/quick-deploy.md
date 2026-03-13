# 快速部署指南

## NPX 一键部署（推荐，跨平台）

```bash
npx @cooper-x-oak/progressive-dev-framework my-project-name
```

这是最简单的方式，适用于所有平台（Windows/Mac/Linux），无需安装任何东西。

## 平台特定命令

### Linux/Mac

```bash
bash <(curl -sSL https://raw.githubusercontent.com/Cooper-X-Oak/progressive-dev-framework/main/scripts/deploy-new-project.sh) my-project-name
```

### Windows PowerShell

**一键部署（推荐）：**

```powershell
iwr https://raw.githubusercontent.com/Cooper-X-Oak/progressive-dev-framework/main/scripts/deploy-new-project.ps1 -OutFile deploy.ps1; .\deploy.ps1; Remove-Item deploy.ps1
```

**如果遇到执行策略错误，先运行：**

```powershell
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
```

**或者使用 Bypass 方式（单次绕过）：**

```powershell
iwr https://raw.githubusercontent.com/Cooper-X-Oak/progressive-dev-framework/main/scripts/deploy-new-project.ps1 -OutFile deploy.ps1; powershell -ExecutionPolicy Bypass -File deploy.ps1; Remove-Item deploy.ps1
```

运行后会提示输入项目名称。

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
