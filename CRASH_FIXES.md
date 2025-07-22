# BTNavigationDropdownMenu Crash Fixes

## 问题描述

根据崩溃报告，BTNavigationDropdownMenu 库在初始化时出现 `EXC_BREAKPOINT (SIGTRAP)` 错误，具体是在 `BTNavigationDropdownMenu.init(navigationController:containerView:title:items:)` 方法中出现了空值解包错误。

## 根本原因分析

通过分析代码，发现了以下几个导致崩溃的问题：

### 1. Bundle 资源加载问题
在 `BTConfiguration.swift` 中，初始化方法使用了强制解包来加载图片资源：
```swift
let imageBundle = Bundle(url: url!)  // 如果 url 为 nil，这里会崩溃
self.checkMarkImage = UIImage(contentsOfFile: checkMarkImagePath!)  // 如果路径为 nil，这里会崩溃
self.arrowImage = UIImage(contentsOfFile: arrowImagePath!)  // 如果路径为 nil，这里会崩溃
```

### 2. UIApplication.shared.keyWindow 可能为 nil
在 iOS 13+ 中，`keyWindow` 已被弃用，在某些情况下可能返回 nil，导致强制解包崩溃。

### 3. navigationController 可能为 nil
如果无法获取到 navigationController，后续的强制解包会导致崩溃。

### 4. 数组越界问题
在访问 `items` 数组时没有进行边界检查。

## 修复方案

### 1. 安全的 Bundle 资源加载
- 添加了空值检查，避免强制解包
- 提供了 fallback 图片生成方法，当资源文件不存在时创建简单的替代图片

### 2. 安全的 Window 获取
- 添加了对 iOS 13+ 的 window scene 支持
- 提供了多层 fallback 策略

### 3. 安全的 NavigationController 处理
- 添加了 navigationController 的空值检查
- 在无法获取 navigationController 时优雅地退出初始化

### 4. 安全的数组访问
- 在访问 `items` 数组前添加了边界检查
- 替换了强制解包为安全的可选值处理

## 修复的具体代码位置

1. **BTConfiguration.swift**
   - 修复了图片资源加载的强制解包问题
   - 添加了 fallback 图片生成方法

2. **BTNavigationDropdownMenu.swift**
   - 修复了 `keyWindow` 的强制解包问题
   - 修复了 `navigationController` 的强制解包问题
   - 修复了数组访问的边界检查问题
   - 修复了其他强制解包问题

## 兼容性

- 保持了与现有 API 的完全兼容性
- 支持 iOS 9.0+ 的所有版本
- 特别优化了对 iOS 13+ 的支持

## 测试

添加了测试方法来验证修复的有效性：
- 测试 nil navigationController 的情况
- 测试 nil containerView 的情况
- 测试空数组的情况
- 测试各种初始化参数组合

## 版本更新

- 版本号从 0.7 更新到 0.8
- 更新了 CHANGELOG.md 记录修复内容
- 更新了 podspec 文件

这些修复确保了 BTNavigationDropdownMenu 在各种边缘情况下都能安全运行，避免了崩溃问题。 