# Pattern: 渐进式状态管理

## 问题

状态管理的常见困境：
- 一开始就用 Redux/Vuex → 学习成本高，可能用不上
- 用组件 state → 状态分散，难以维护
- 后期重构成本高 → 状态散落各处

## 思路

从最简单的本地状态开始，根据复杂度逐步演进。

## 实践案例

### 1. Demo 阶段（组件本地状态）

```javascript
// demo/counter.html
let count = 0;

function increment() {
  count++;
  render();
}

function render() {
  document.getElementById('count').textContent = count;
}
```

**优点**：简单直接
**问题**：状态分散，难以共享

### 2. 重构阶段（集中状态）

```javascript
// src/state/store.js
const state = {
  count: 0,
  user: null,
  todos: []
};

const listeners = [];

function getState() {
  return state;
}

function setState(updates) {
  Object.assign(state, updates);
  listeners.forEach(fn => fn(state));
}

function subscribe(fn) {
  listeners.push(fn);
  return () => {
    const index = listeners.indexOf(fn);
    if (index > -1) listeners.splice(index, 1);
  };
}

export { getState, setState, subscribe };
```

### 3. 模式沉淀（可复用状态管理）

```javascript
// patterns/progressive-state-manager.js

/**
 * 渐进式状态管理模式
 *
 * 特点：
 * 1. 从简单的全局对象开始
 * 2. 逐步添加订阅、中间件
 * 3. 最后支持模块化
 */

class ProgressiveStore {
  constructor(initialState = {}) {
    this.state = initialState;
    this.listeners = new Set();
    this.middlewares = [];
    this.modules = {};
  }

  // 获取状态
  getState(path) {
    if (!path) return this.state;

    return path.split('.').reduce((obj, key) => obj?.[key], this.state);
  }

  // 设置状态
  setState(updates, path) {
    const oldState = { ...this.state };

    if (path) {
      // 支持路径更新：setState({ name: 'John' }, 'user')
      const keys = path.split('.');
      let target = this.state;

      for (let i = 0; i < keys.length - 1; i++) {
        target = target[keys[i]];
      }

      target[keys[keys.length - 1]] = {
        ...target[keys[keys.length - 1]],
        ...updates
      };
    } else {
      Object.assign(this.state, updates);
    }

    // 执行中间件
    this.middlewares.forEach(middleware => {
      middleware(oldState, this.state, updates);
    });

    // 通知订阅者
    this.listeners.forEach(fn => fn(this.state, oldState));
  }

  // 订阅状态变化
  subscribe(fn, path) {
    if (path) {
      // 只订阅特定路径
      const wrappedFn = (newState, oldState) => {
        const newValue = this.getState(path);
        const oldValue = path.split('.').reduce((obj, key) => obj?.[key], oldState);

        if (newValue !== oldValue) {
          fn(newValue, oldValue);
        }
      };

      this.listeners.add(wrappedFn);
      return () => this.listeners.delete(wrappedFn);
    }

    this.listeners.add(fn);
    return () => this.listeners.delete(fn);
  }

  // 添加中间件
  use(middleware) {
    this.middlewares.push(middleware);
    return this;
  }

  // 模块化
  registerModule(name, module) {
    this.modules[name] = module;
    this.state[name] = module.state || {};

    // 为模块创建 actions
    if (module.actions) {
      this[name] = {};
      Object.keys(module.actions).forEach(actionName => {
        this[name][actionName] = (...args) => {
          return module.actions[actionName](this, ...args);
        };
      });
    }

    return this;
  }
}

// 使用示例
const store = new ProgressiveStore({
  count: 0,
  user: null
});

// 基础使用
store.setState({ count: 1 });
console.log(store.getState('count')); // 1

// 订阅变化
store.subscribe((newState, oldState) => {
  console.log('State changed:', newState);
});

// 只订阅特定字段
store.subscribe((newValue, oldValue) => {
  console.log('Count changed:', newValue);
}, 'count');

// 添加日志中间件
store.use((oldState, newState, updates) => {
  console.log('State update:', updates);
});

// 模块化
store.registerModule('todos', {
  state: {
    items: [],
    filter: 'all'
  },
  actions: {
    addTodo(store, text) {
      const todos = store.getState('todos.items');
      store.setState({
        items: [...todos, { id: Date.now(), text, done: false }]
      }, 'todos');
    },
    toggleTodo(store, id) {
      const todos = store.getState('todos.items');
      store.setState({
        items: todos.map(todo =>
          todo.id === id ? { ...todo, done: !todo.done } : todo
        )
      }, 'todos');
    }
  }
});

// 使用模块
store.todos.addTodo('Learn Progressive Dev');
store.todos.toggleTodo(1);
```

## 演进路径

```
Demo (30分钟)
  ↓ 多个组件需要共享状态
重构 (1小时)
  ↓ 需要订阅、中间件
模式 (2小时)
  ↓ 需要模块化管理
```

## 关键决策

1. **何时集中状态**：当2个以上组件需要共享状态时
2. **何时添加订阅**：当需要响应状态变化时
3. **何时模块化**：当状态超过5个顶层字段时

## 渐进式添加功能

```javascript
// 阶段1：简单状态
const state = { count: 0 };

// 阶段2：添加订阅
store.subscribe(render);

// 阶段3：添加中间件
store.use(logger);
store.use(persist);

// 阶段4：模块化
store.registerModule('todos', todoModule);
store.registerModule('user', userModule);
```

## 常用中间件示例

```javascript
// 日志中间件
const logger = (oldState, newState, updates) => {
  console.group('State Update');
  console.log('Old:', oldState);
  console.log('Updates:', updates);
  console.log('New:', newState);
  console.groupEnd();
};

// 持久化中间件
const persist = (oldState, newState) => {
  localStorage.setItem('app-state', JSON.stringify(newState));
};

// 时间旅行中间件
const history = [];
const timeTravel = (oldState, newState) => {
  history.push(oldState);
  if (history.length > 50) history.shift();
};
```

## 适用场景

- ✅ 状态管理需求不明确
- ✅ 团队对 Redux 等库不熟悉
- ✅ 需要快速迭代
- ❌ 已有成熟的状态管理方案
- ❌ 需要复杂的状态逻辑

## 相关模式

- [渐进式表单验证](./progressive-form-validation.md)
- [渐进式 API 客户端](./progressive-api-client.md)
