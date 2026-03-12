# 如何使用这个框架

## 方式一：作为新项目的起点

### 1. 获取框架

```bash
# 克隆框架
git clone https://github.com/your-username/progressive-dev-framework.git my-new-project
cd my-new-project

# 删除原有的 git 历史，开始新项目
rm -rf .git
git init
```

### 2. 定制化

1. **更新 CLAUDE.md**
   
   - 修改项目名称和定位
   - 添加你的技术栈
   - 补充项目特定的约定

2. **更新 README.md**
   
   - 改为你的项目介绍
   - 添加项目特定的说明

3. **清理示例文件**
   
   - 删除 `demo/hello-htmler.html`
   - 清空 `demo/notes.md`
   - 删除 `docs/setup-complete.md`

### 3. 开始开发

```bash
# 使用 /demo-design 开始第一个功能
/demo-design
```

## 方式二：学习和参考

直接浏览框架结构，了解渐进式开发的理念：

1. 阅读 [渐进式开发模式](../patterns/progressive-development.md)
2. 查看 [Skills 说明](skills.md)
3. 参考目录结构组织自己的项目

## 方式三：贡献改进

如果你有好的想法改进这个框架：

1. Fork 这个仓库
2. 创建你的特性分支
3. 提交 Pull Request

## 定制建议

### 最小定制

只需修改：

- CLAUDE.md（项目名称和技术栈）
- README.md（项目介绍）

### 完整定制

根据项目需要：

- 添加新的 Skills
- 创建项目特定的模式
- 调整目录结构
- 添加工具和脚本

## 注意事项

- 保持 `patterns/` 目录的模式是通用的方法论
- 项目特定的内容放在 `docs/` 或 CLAUDE.md 中
- Skills 应该是可复用的工作流程
