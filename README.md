# Legado

Legado是一个面向iOS的小说阅读器实验项目，目标是将Android开源阅读器[legado（阅读）](https://github.com/gedoor/legado)的书源生态移植到Apple平台，让同一套社区书源规则可以用于搜索、详情、目录、正文阅读与离线缓存。iOS27正常运行

# 本APP只做阅读器

## 此 fork 的 IPA 构建

在本仓库的 **Actions → Build unsigned iOS IPA → Run workflow** 中选择 `master`，等待任务成功后，下载产物 **Legado-unsigned-ipa**。解压产物 ZIP，得到 `Legado-unsigned.ipa` 和 SHA-256 校验文件。

- 使用 macOS 26、Xcode 26.6、CocoaPods 1.17.0，按 `Podfile.lock` 安装依赖。
- 构建 iPhone/iPad 的 Release 包，最低支持 iOS 18.6。
- IPA 未签名，安装前需要通过 SideStore、AltStore 或已有签名工具重新签名。
- IPA 产物保留 14 天；编译日志保留 7 天，过期后可重新运行工作流。
- 构建包含 RSA 固定样例回归、arm64 架构和 IPA ZIP 完整性校验；实际书源兼容性仍需在设备上验证。

`Podfile` 的安装钩子恢复了原始 [SwiftLegado 的 SwCrypt 修改](https://github.com/Apolla/swiftLegado/blob/master/Pods/SwCrypt/SwCrypt/SwCrypt.swift)中的 `CC.RSA.rawCrypt` 包装方法，否则从全新检出编译时会缺少该方法。依赖库版本保持上游锁定值。

## 功能

- 导入和管理社区书源，支持多书源搜索。
- 浏览书籍详情、目录与正文，并支持阅读时切换可用书源。
- 提供书架、阅读进度、目录及章节离线缓存。
- 支持正文净化规则、主题与字体、本地书、RSS订阅和备份恢复等能力。

## 目录

```text
Legado/
├── Legado/                 # App源码
│   ├── LegadoSwiftParser/  # 书源解析与请求运行时
│   ├── BookSourceManager/  # 书源导入与管理
│   ├── Search/             # 多源搜索
│   ├── Bookshelf/          # 书架与缓存
│   ├── Reader/             # 阅读器
│   └── ReplaceRule/        # 正文净化规则
├── LegadoTests/            # 测试
├── Podfile                 # CocoaPods依赖定义
└── Legado.xcworkspace      # Xcode打开入口
```

## 致谢

本项目在早期实现中参考了[Apolla/swiftLegado](https://github.com/Apolla/swiftLegado)，并以Legado作为独立项目持续维护。

书源规则生态来源于Android开源项目[legado（阅读）](https://github.com/gedoor/legado)。本项目不隶属于Android legado官方；书源由社区维护，使用者应遵守当地法律法规及目标站点规则。
