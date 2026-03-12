# 项目结构总览

```
progressive-dev-framework/
├── CLAUDE.md                      # Claude 项目配置和开发约定
├── README.md                      # 项目主文档
├── .gitignore                     # Git 忽略配置
│
├── demo/                          # 功能验证和快速原型
│   ├── README.md                  # Demo 使用指南
│   ├── notes.md                   # 实验笔记和待办
│   └── hello-htmler.html          # 示例 demo 文件
│
├── src/                           # 系统化的核心代码
│   ├── README.md                  # 代码组织说明
│   ├── core/                      # 核心功能模块
│   ├── utils/                     # 工具函数
│   └── components/                # 可复用组件
│
├── patterns/                      # 解决问题的思路模式库
│   ├── README.md                  # 模式库说明和索引
│   ├── template.md                # 模式文档模板
│   └── progressive-development.md # 渐进式开发模式
│
└── docs/                          # 文档和决策记录
    ├── getting-started.md         # 快速开始指南
    ├── decisions.md               # 架构决策记录
    └── structure.md               # 本文件
```

## 目录说明

### demo/
快速验证想法的实验场，代码可以不完美，重点是验证可行性。

### src/
经过验证的系统化代码，注重可维护性和复用性。

### patterns/
沉淀的方法论和思路模式，类似 OpenSpec 的理念。

### docs/
项目文档和重要决策记录。

## 文件流转

```
想法 → demo/验证 → src/提炼 → patterns/沉淀
```

每个阶段都有明确的目标和产出。
