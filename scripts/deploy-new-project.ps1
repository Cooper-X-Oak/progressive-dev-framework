# Progressive Dev Framework - PowerShell 快速部署脚本

param(
    [Parameter(Mandatory=$true)]
    [string]$ProjectName,

    [Parameter(Mandatory=$false)]
    [string]$TargetDir = "."
)

$ProjectPath = Join-Path $TargetDir $ProjectName

Write-Host "🚀 开始部署 Progressive Dev Framework..." -ForegroundColor Green
Write-Host "📁 项目名称: $ProjectName"
Write-Host "📂 目标路径: $ProjectPath"
Write-Host ""

# 克隆框架
git clone --depth 1 https://github.com/Cooper-X-Oak/progressive-dev-framework.git $ProjectPath 2>$null

Set-Location $ProjectPath

# 删除原有 git 历史
Remove-Item -Recurse -Force .git

# 初始化新的 git 仓库
git init -q
git add .
git commit -q -m "Initial commit based on Progressive Dev Framework"

Write-Host ""
Write-Host "✅ 部署完成！" -ForegroundColor Green
Write-Host ""
Write-Host "下一步："
Write-Host "  cd $ProjectPath"
Write-Host "  # 修改 CLAUDE.md 和 README.md 为你的项目信息"
Write-Host "  # 开始在 demo/ 目录验证你的想法"
Write-Host ""
Write-Host "可用的 Skills:"
Write-Host "  /demo-design  - 设计 demo 功能"
Write-Host "  /capture-pattern - 沉淀可复用模式"
