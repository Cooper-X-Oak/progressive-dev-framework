# Pattern: API 请求渐进式封装

## 问题

API 请求的封装经常遇到：
- 一开始用 fetch 直接写 → 重复代码多
- 直接上 axios + 拦截器 → 过度设计，需求未明确
- 后期改造成本高 → 到处都是硬编码

## 思路

从最简单的 fetch 开始，根据实际需求逐步封装。

## 实践案例

### 1. Demo 阶段（直接 fetch）

```javascript
// demo/user-list.html
async function getUsers() {
  const response = await fetch('https://api.example.com/users');
  const data = await response.json();
  console.log(data);
}

async function createUser(userData) {
  const response = await fetch('https://api.example.com/users', {
    method: 'POST',
    headers: { 'Content-Type': 'application/json' },
    body: JSON.stringify(userData)
  });
  return response.json();
}
```

**优点**：简单直接，快速验证 API
**问题**：重复代码，错误处理缺失

### 2. 重构阶段（提炼公共逻辑）

```javascript
// src/api/request.js
const API_BASE = 'https://api.example.com';

async function request(endpoint, options = {}) {
  const url = `${API_BASE}${endpoint}`;
  const config = {
    headers: {
      'Content-Type': 'application/json',
      ...options.headers
    },
    ...options
  };

  try {
    const response = await fetch(url, config);

    if (!response.ok) {
      throw new Error(`HTTP ${response.status}: ${response.statusText}`);
    }

    return await response.json();
  } catch (error) {
    console.error('API Error:', error);
    throw error;
  }
}

// 使用
export const api = {
  getUsers: () => request('/users'),
  createUser: (data) => request('/users', {
    method: 'POST',
    body: JSON.stringify(data)
  })
};
```

### 3. 模式沉淀（可复用的 API 客户端）

```javascript
// patterns/progressive-api-client.js

/**
 * 渐进式 API 客户端模式
 *
 * 特点：
 * 1. 从简单的 fetch 封装开始
 * 2. 根据需求逐步添加功能
 * 3. 保持简单，避免过度设计
 */

class ProgressiveAPIClient {
  constructor(config = {}) {
    this.baseURL = config.baseURL || '';
    this.headers = config.headers || {};
    this.interceptors = {
      request: [],
      response: []
    };
  }

  // 添加请求拦截器
  addRequestInterceptor(fn) {
    this.interceptors.request.push(fn);
    return this;
  }

  // 添加响应拦截器
  addResponseInterceptor(fn) {
    this.interceptors.response.push(fn);
    return this;
  }

  // 核心请求方法
  async request(endpoint, options = {}) {
    let url = endpoint.startsWith('http')
      ? endpoint
      : `${this.baseURL}${endpoint}`;

    let config = {
      headers: {
        'Content-Type': 'application/json',
        ...this.headers,
        ...options.headers
      },
      ...options
    };

    // 执行请求拦截器
    for (const interceptor of this.interceptors.request) {
      const result = await interceptor({ url, config });
      if (result) {
        url = result.url || url;
        config = result.config || config;
      }
    }

    try {
      let response = await fetch(url, config);

      // 执行响应拦截器
      for (const interceptor of this.interceptors.response) {
        response = await interceptor(response) || response;
      }

      if (!response.ok) {
        throw new Error(`HTTP ${response.status}: ${response.statusText}`);
      }

      return await response.json();
    } catch (error) {
      console.error('API Error:', error);
      throw error;
    }
  }

  // 便捷方法
  get(endpoint, options) {
    return this.request(endpoint, { ...options, method: 'GET' });
  }

  post(endpoint, data, options) {
    return this.request(endpoint, {
      ...options,
      method: 'POST',
      body: JSON.stringify(data)
    });
  }

  put(endpoint, data, options) {
    return this.request(endpoint, {
      ...options,
      method: 'PUT',
      body: JSON.stringify(data)
    });
  }

  delete(endpoint, options) {
    return this.request(endpoint, { ...options, method: 'DELETE' });
  }

  // 创建资源 API
  resource(name) {
    return {
      list: (params) => this.get(`/${name}`, { params }),
      get: (id) => this.get(`/${name}/${id}`),
      create: (data) => this.post(`/${name}`, data),
      update: (id, data) => this.put(`/${name}/${id}`, data),
      delete: (id) => this.delete(`/${name}/${id}`)
    };
  }
}

// 使用示例
const api = new ProgressiveAPIClient({
  baseURL: 'https://api.example.com'
});

// 添加认证拦截器
api.addRequestInterceptor(({ url, config }) => {
  const token = localStorage.getItem('token');
  if (token) {
    config.headers.Authorization = `Bearer ${token}`;
  }
  return { url, config };
});

// 添加错误处理拦截器
api.addResponseInterceptor(async (response) => {
  if (response.status === 401) {
    // 处理未授权
    window.location.href = '/login';
  }
  return response;
});

// 创建资源 API
const users = api.resource('users');
const posts = api.resource('posts');

// 使用
await users.list();
await users.get(1);
await users.create({ name: 'John' });
await posts.list();
```

## 演进路径

```
Demo (30分钟)
  ↓ 发现重复代码
重构 (1小时)
  ↓ 需要认证、错误处理
模式 (2小时)
  ↓ 多个项目需要类似封装
```

## 关键决策

1. **何时重构**：当有3个以上相似的 API 调用时
2. **何时添加拦截器**：当需要统一处理认证或错误时
3. **何时使用 resource**：当有标准的 CRUD 操作时

## 渐进式添加功能

```javascript
// 阶段1：基础请求
api.get('/users')

// 阶段2：添加认证
api.addRequestInterceptor(addAuthToken)

// 阶段3：添加重试
api.addRequestInterceptor(retryOnFailure)

// 阶段4：添加缓存
api.addResponseInterceptor(cacheResponse)

// 阶段5：资源化
const users = api.resource('users')
```

## 适用场景

- ✅ API 接口不稳定，可能变化
- ✅ 需要快速验证功能
- ✅ 团队对 axios 等库不熟悉
- ❌ 已有成熟的 API 层
- ❌ 需要复杂的请求配置

## 相关模式

- [渐进式状态管理](./progressive-state-management.md)
- [渐进式错误处理](./progressive-error-handling.md)
