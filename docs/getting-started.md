# 快速开始指南

## 第一步：验证项目结构

打开 `demo/hello-htmler.html` 在浏览器中查看，确认项目结构正常。

## 第二步：开始你的第一个功能

1. **创建 demo 文件**
   ```bash
   # 在 demo/ 目录下创建新文件
   # 例如：demo/my-feature.html
   ```

2. **快速实现和测试**
   - 不用担心代码质量，专注于验证想法
   - 直接在浏览器中打开测试
   - 在 `demo/notes.md` 中记录发现

3. **功能验证通过后**
   - 重构代码到 `src/` 目录
   - 提取可复用的模块
   - 更新文档

## 第三步：沉淀你的思路

当你发现一个管用的解决方案时：

1. 复制 `patterns/template.md` 创建新模式文件
2. 记录问题、思路、适用场景
3. 在 `patterns/README.md` 中添加索引

## 常用命令

```bash
# 查看项目结构
tree -L 2

# 在浏览器中打开 demo
open demo/hello-htmler.html  # macOS
start demo/hello-htmler.html # Windows
```

## 下一步

- 查看 [CLAUDE.md](../CLAUDE.md) 了解开发约定
- 阅读 [渐进式开发模式](../patterns/progressive-development.md)
- 开始在 demo/ 中验证你的第一个想法
