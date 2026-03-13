# Pattern: 渐进式表单验证

## 问题

表单验证经常面临两难：
- 一开始就写完整验证 → 过度设计，需求可能变化
- 完全不验证 → 后期补充困难，容易遗漏

## 思路

**Demo 阶段**：只验证核心字段，用最简单的方式
**重构阶段**：提炼验证逻辑，建立验证规则
**模式阶段**：形成可复用的验证框架

## 实践案例

### 1. Demo 验证（快速实现）

```javascript
// demo/login-form.html
function validateLogin() {
  const email = document.getElementById('email').value;
  const password = document.getElementById('password').value;

  // 只验证最基本的
  if (!email || !password) {
    alert('请填写邮箱和密码');
    return false;
  }

  if (!email.includes('@')) {
    alert('邮箱格式不正确');
    return false;
  }

  return true;
}
```

**优点**：
- 快速验证核心流程
- 代码简单直接
- 容易修改

### 2. 重构阶段（提炼规则）

```javascript
// src/validation/rules.js
const validationRules = {
  email: {
    required: true,
    pattern: /^[^\s@]+@[^\s@]+\.[^\s@]+$/,
    message: '请输入有效的邮箱地址'
  },
  password: {
    required: true,
    minLength: 6,
    message: '密码至少6位'
  }
};

function validate(field, value) {
  const rule = validationRules[field];
  if (!rule) return { valid: true };

  if (rule.required && !value) {
    return { valid: false, message: `${field}不能为空` };
  }

  if (rule.pattern && !rule.pattern.test(value)) {
    return { valid: false, message: rule.message };
  }

  if (rule.minLength && value.length < rule.minLength) {
    return { valid: false, message: rule.message };
  }

  return { valid: true };
}
```

### 3. 模式沉淀（可复用框架）

```javascript
// patterns/form-validation-pattern.js

/**
 * 渐进式表单验证模式
 *
 * 核心思想：
 * 1. 从简单的必填验证开始
 * 2. 逐步添加格式验证
 * 3. 最后加入业务规则验证
 */

class ProgressiveValidator {
  constructor() {
    this.rules = {};
    this.validators = {
      required: (value) => !!value,
      email: (value) => /^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(value),
      minLength: (value, min) => value.length >= min,
      maxLength: (value, max) => value.length <= max,
      pattern: (value, regex) => regex.test(value)
    };
  }

  // 添加验证规则
  addRule(field, rules) {
    this.rules[field] = rules;
    return this;
  }

  // 验证单个字段
  validateField(field, value) {
    const rules = this.rules[field];
    if (!rules) return { valid: true };

    for (const [ruleName, ruleValue] of Object.entries(rules)) {
      if (ruleName === 'message') continue;

      const validator = this.validators[ruleName];
      if (!validator) continue;

      const isValid = typeof ruleValue === 'boolean'
        ? validator(value)
        : validator(value, ruleValue);

      if (!isValid) {
        return {
          valid: false,
          field,
          message: rules.message || `${field} 验证失败`
        };
      }
    }

    return { valid: true };
  }

  // 验证整个表单
  validateForm(formData) {
    const errors = [];

    for (const [field, value] of Object.entries(formData)) {
      const result = this.validateField(field, value);
      if (!result.valid) {
        errors.push(result);
      }
    }

    return {
      valid: errors.length === 0,
      errors
    };
  }

  // 自定义验证器
  addValidator(name, fn) {
    this.validators[name] = fn;
    return this;
  }
}

// 使用示例
const validator = new ProgressiveValidator()
  .addRule('email', {
    required: true,
    email: true,
    message: '请输入有效的邮箱地址'
  })
  .addRule('password', {
    required: true,
    minLength: 6,
    message: '密码至少6位'
  });

// 验证
const result = validator.validateForm({
  email: 'user@example.com',
  password: '123456'
});

console.log(result); // { valid: true, errors: [] }
```

## 演进路径

```
Demo (1小时)
  ↓ 发现需要更多字段验证
重构 (2小时)
  ↓ 多个表单需要类似验证
模式 (3小时)
  ↓ 形成可复用的验证框架
```

## 关键决策

1. **何时重构**：当第二个表单需要验证时
2. **何时沉淀**：当验证逻辑在3个以上地方重复时
3. **如何扩展**：通过 `addValidator` 添加自定义规则

## 适用场景

- ✅ 表单验证需求不明确
- ✅ 验证规则可能频繁变化
- ✅ 需要快速迭代
- ❌ 已有成熟的验证库（如 Yup, Joi）
- ❌ 验证规则非常复杂且固定

## 相关模式

- [渐进式状态管理](./progressive-state-management.md)
- [渐进式错误处理](./progressive-error-handling.md)
