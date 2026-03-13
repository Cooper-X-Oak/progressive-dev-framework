#!/usr/bin/env node

const { execSync } = require('child_process');
const fs = require('fs');
const path = require('path');

// 获取项目名称
const projectName = process.argv[2];

if (!projectName) {
  console.log('用法: npx @cooper-x-oak/progressive-dev-framework <项目名称>');
  console.log('示例: npx @cooper-x-oak/progressive-dev-framework my-project');
  process.exit(1);
}

const targetPath = path.join(process.cwd(), projectName);

console.log('🚀 开始部署 Progressive Dev Framework...');
console.log(`📁 项目名称: ${projectName}`);
console.log(`📂 目标路径: ${targetPath}`);
console.log('');

try {
  // 克隆框架
  console.log('⬇️  克隆框架...');
  execSync(
    `git clone --depth 1 https://github.com/Cooper-X-Oak/progressive-dev-framework.git "${targetPath}"`,
    { stdio: 'inherit' }
  );

  // 进入项目目录
  process.chdir(targetPath);

  // 删除 .git 目录
  console.log('🧹 清理 git 历史...');
  fs.rmSync('.git', { recursive: true, force: true });

  // 清理框架相关文件
  console.log('🧹 清理多余文件...');
  fs.rmSync('scripts', { recursive: true, force: true });
  fs.rmSync('package.json', { force: true });
  fs.rmSync('bin', { recursive: true, force: true });

  const docsToRemove = [
    'docs/project-history.md',
    'docs/setup-complete.md',
    'docs/summary.md',
    'docs/release-checklist.md',
    'docs/quick-deploy.md'
  ];
  docsToRemove.forEach(file => {
    try {
      fs.unlinkSync(file);
    } catch (e) {}
  });

  try {
    fs.unlinkSync('demo/hello-htmler.html');
  } catch (e) {}

  // 初始化新的 git 仓库
  console.log('📦 初始化 git 仓库...');
  execSync('git init', { stdio: 'inherit' });
  execSync('git add .', { stdio: 'inherit' });
  execSync('git commit -m "Initial commit based on Progressive Dev Framework"', { stdio: 'inherit' });

  console.log('');
  console.log('✅ 部署完成！');
  console.log('');
  console.log('下一步：');
  console.log(`  cd ${projectName}`);
  console.log('  # 修改 CLAUDE.md 和 README.md 为你的项目信息');
  console.log('  # 开始在 demo/ 目录验证你的想法');
  console.log('');
  console.log('可用的 Skills:');
  console.log('  /demo-design  - 设计 demo 功能');
  console.log('  /capture-pattern - 沉淀可复用模式');
} catch (error) {
  console.error('❌ 部署失败:', error.message);
  process.exit(1);
}
