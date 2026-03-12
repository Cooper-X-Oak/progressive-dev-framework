# Progressive Dev Framework

一个渐进式开发框架模板，帮助你在快速迭代和代码质量之间找到平衡。

## 核心特性

- 🚀 **Demo 优先** - 快速验证想法，不受约束
- 🔄 **渐进式演进** - 从原型到系统化代码的自然过渡
- 📚 **模式沉淀** - 像 OpenSpec 一样积累可复用的思路
- 🛠️ **内置 Skills** - 自动化常见工作流程

## 项目结构

```
progressive-dev-framework/
├── CLAUDE.md          # Claude 项目配置和开发约定
├── demo/              # 功能验证和快速原型
├── src/               # 系统化的核心代码
├── patterns/          # 解决问题的思路模式库
└── docs/              # 架构决策和文档
```

## 快速部署

### 一行命令（推荐）

```bash
# Linux/Mac
bash <(curl -sSL https://raw.githubusercontent.com/Cooper-X-Oak/progressive-dev-framework/main/scripts/deploy-new-project.sh) my-project-name

# Windows PowerShell
irm https://raw.githubusercontent.com/Cooper-X-Oak/progressive-dev-framework/main/scripts/deploy-new-project.ps1 | iex
```

### 其他方式

- **GitHub Template** - 点击 "Use this template" 按钮
- **手动克隆** - `git clone --depth 1 https://github.com/Cooper-X-Oak/progressive-dev-framework.git my-project`

详见 [快速部署指南](docs/quick-deploy.md)

## 使用方式

### 开发流程

1. 在 `demo/` 中快速验证想法
2. 将成熟功能提炼到 `src/`
3. 把管用的思路沉淀到 `patterns/`
4. 在 `docs/` 中记录重要决策

## 快速开始

```bash
# 1. 在浏览器中打开第一个 demo
open demo/hello-htmler.html  # macOS
start demo/hello-htmler.html # Windows

# 2. 查看快速开始指南
cat docs/getting-started.md
```

或者直接：

1. 查看 `CLAUDE.md` 了解项目约定
2. 在 `demo/` 中开始你的第一个功能验证
3. 参考 `patterns/template.md` 记录你的思路

## 文档导航

- [如何使用这个框架](docs/how-to-use.md) ⭐
- [快速开始指南](docs/getting-started.md)
- [框架配置](CLAUDE.md)
- [Skills 说明](docs/skills.md)
- [Demo 使用指南](demo/README.md)
- [模式库说明](patterns/README.md)
- [架构决策](docs/decisions.md)
- [项目结构](docs/structure.md)

## 贡献

欢迎提交 Issue 和 Pull Request 来改进这个框架！

详见 [贡献指南](CONTRIBUTING.md)

## 更新日志

查看 [CHANGELOG.md](CHANGELOG.md) 了解版本历史和计划。

## License

MIT License - 详见 [LICENSE](LICENSE) 文件
