---
name: yt-dlp-downloader
description: 交互式 yt-dlp 视频下载器，支持 YouTube、Bilibili 等 1000+ 网站，智能选择质量、格式和字幕
license: Unlicense
compatibility: opencode
metadata:
  author: pigeon-video-download
  version: 1.0.0
  category: media-downloader
---

# yt-dlp-downloader - 交互式视频下载器

基于 yt-dlp 的交互式视频下载工具，支持从 1000+ 网站（YouTube、Bilibili、TikTok、Twitter 等）下载视频、音频和播放列表。

## 快速开始

### 交互式下载流程

当你提供一个视频链接时，系统将引导你完成以下步骤：

1. **识别视频源** - 自动检测网站类型（YouTube、Bilibili 等）
2. **选择下载类型** - 视频 / 音频 / 两者
3. **选择质量** - 自动推荐 / 720p / 1080p / 1440p / 4K / 最佳质量
4. **选择格式** - MP4 / MKV / WebM / MP3 / M4A / FLAC 等
5. **字幕选项** - 无字幕 / 中文字幕 / 英文字幕 / 全部 / 自动生成
6. **缩略图** - 是否下载视频缩略图
7. **保存路径** - 默认路径或自定义目录
8. **执行下载** - 自动生成并执行 yt-dlp 命令

## 预设方案

### 🚀 快速下载（推荐）
适用于大多数场景，默认下载 1080p MP4 视频
```bash
yt-dlp -f "bestvideo[height<=1080]+bestaudio" --merge-output-format mp4 "URL"
```

### 🎵 音频提取
从视频提取音频，保存为 MP3 格式
```bash
yt-dlp -x --audio-format mp3 "URL"
```

### 📺 高质量下载
下载最高可用质量（最高 4K/8K）
```bash
yt-dlp -f "bestvideo+bestaudio/best" --merge-output-format mp4 "URL"
```

### 📚 播放列表下载
下载整个播放列表，使用 1080p MP4 格式
```bash
yt-dlp -f "bestvideo[height<=1080]+bestaudio" --merge-output-format mp4 "PLAYLIST_URL"
```

## 交互式配置选项

### 下载类型
- **视频** - 下载视频文件（包含音频）
- **音频** - 仅提取音频
- **两者** - 分别下载视频和音频

### 质量选择
- **自动** - 根据网络情况自动选择（推荐）
- **720p** - 高清，文件较小
- **1080p** - 全高清，推荐选择
- **1440p** - 2K，高质量
- **4K** - 超高清，文件较大
- **最佳** - 最高可用质量

### 输出格式
**视频格式：**
- **MP4** - 通用兼容，推荐
- **MKV** - 开源格式，支持更多编码
- **WebM** - Google 开源，Web 优化

**音频格式：**
- **MP3** - 最通用，兼容性最好
- **M4A** - Apple 格式，高质量
- **FLAC** - 无损压缩，发烧友选择
- **AAC** - 高效编码
- **Opus** - 现代高效编码

### 字幕选项
- **无字幕** - 仅下载视频
- **中文字幕** - 下载中文字幕
- **英文字幕** - 下载英文字幕
- **全部语言** - 下载所有可用字幕
- **自动生成** - 下载平台生成的字幕（如 YouTube 自动字幕）

### 缩略图选项
- **不下载** - 仅下载视频
- **下载缩略图** - 保存视频封面图片

## 常用命令参考

### 基础命令

#### 查看可用格式
```bash
yt-dlp -F "URL"
```

#### 下载单个视频（最佳质量）
```bash
yt-dlp "URL"
```

#### 下载指定格式
```bash
yt-dlp -f "bestvideo[height<=1080]+bestaudio" "URL"
```

#### 自定义输出路径
```bash
yt-dlp -o "%(title)s.%(ext)s" "URL"
yt-dlp -o "~/Videos/%(uploader)s/%(title)s.%(ext)s" "URL"
```

### 高级选项

#### 下载字幕和缩略图
```bash
yt-dlp --write-subs --write-thumbnail "URL"
```

#### 嵌入字幕到视频
```bash
yt-dlp --write-subs --embed-subs "URL"
```

#### 使用代理
```bash
yt-dlp --proxy socks5://127.0.0.1:1080 "URL"
```

#### 限制下载速度
```bash
yt-dlp --limit-rate 2M "URL"
```

#### YouTube 特定选项
```bash
yt-dlp --js-runtimes node --impersonate chrome "URL"
```

### 音频提取

#### 提取为 MP3
```bash
yt-dlp -x --audio-format mp3 "URL"
```

#### 提取为 FLAC（无损）
```bash
yt-dlp -x --audio-format flac "URL"
```

#### 高质量音频
```bash
yt-dlp -x --audio-format mp3 --audio-quality 0 "URL"
```

### 播放列表处理

#### 下载整个播放列表
```bash
yt-dlp "PLAYLIST_URL"
```

#### 下载特定范围
```bash
yt-dlp --playlist-start 1 --playlist-end 10 "PLAYLIST_URL"
```

#### 仅获取播放列表信息
```bash
yt-dlp --flat-playlist "PLAYLIST_URL"
```

#### 批量提取音频
```bash
yt-dlp -x --audio-format mp3 "PLAYLIST_URL"
```

## 输出模板变量

常用模板变量：
- `%(title)s` - 视频标题
- `%(uploader)s` - 上传者/频道名
- `%(id)s` - 视频 ID
- `%(ext)s` - 文件扩展名
- `%(upload_date)s` - 上传日期 (YYYYMMDD)
- `%(duration)s` - 时长（秒）
- `%(view_count)s` - 观看次数
- `%(playlist_index)s` - 播放列表中的序号
- `%(playlist_title)s` - 播放列表标题

### 输出模板示例

```bash
按频道分类：
yt-dlp -o "%(uploader)s/%(title)s.%(ext)s" "URL"

按日期分类：
yt-dlp -o "%(upload_date)s/%(title)s.%(ext)s" "URL"

完整信息：
yt-dlp -o "%(uploader)s/%(upload_date)s_%(title)s.%(ext)s" "URL"
```

## 格式选择指南

### 基本格式
- `best` - 最佳质量（默认）
- `bestvideo` - 最佳视频流
- `bestaudio` - 最佳音频流
- `worst` - 最低质量

### 格式组合
- `bestvideo+bestaudio` - 最佳视频+最佳音频（自动合并）
- `bestvideo[height<=1080]+bestaudio` - 最高 1080p 视频+最佳音频
- `(bestvideo+bestaudio)/best` - 优先合并，否则使用最佳单文件

### 按分辨率
- `bestvideo[height<=720]` - 最高 720p
- `bestvideo[height<=1080]` - 最高 1080p
- `bestvideo[height<=1440]` - 最高 1440p
- `bestvideo[height<=2160]` - 最高 4K

### 按格式
- `bestvideo[ext=mp4]+bestaudio[ext=m4a]` - MP4 视频 + M4A 音频

## 支持的网站

主要支持（部分列表）：
- **YouTube** - 视频和播放列表
- **Bilibili** - 视频、番剧、课程
- **TikTok** - 短视频
- **Twitter/X** - 媒体内容
- **Instagram** - Reels、IGTV
- **Vimeo** - 专业视频
- **Twitch** - 直播和录制
- **Facebook** - 视频
- **Reddit** - 媒体内容

完整支持的网站列表：查看 yt-dlp 文档

## 故障排除

### 常见错误

#### 警告：No supported JavaScript runtime
**原因**：YouTube 等网站需要 JavaScript 运行时  
**解决**：
```bash
yt-dlp --js-runtimes node "URL"
```

#### 下载速度慢
**解决**：
```bash
增加并发片段：
yt-dlp --concurrent-fragments 4 "URL"

使用代理：
yt-dlp --proxy socks5://127.0.0.1:1080 "URL"
```

#### 合并失败
**原因**：缺少 ffmpeg  
**解决**：
```bash
安装 ffmpeg 后：
yt-dlp --merge-output-format mp4 "URL"
```

#### 视频格式不可用
**解决**：
```bash
查看所有可用格式：
yt-dlp -F "URL"

使用 JS 运行时：
yt-dlp --js-runtimes node "URL"
```

### 文件名问题

#### 文件名过长或包含特殊字符
**解决**：
```bash
限制文件名长度：
yt-dlp --trim-filenames 50 "URL"

使用 ASCII 字符：
yt-dlp --restrict-filenames "URL"
```

### 网络问题

#### 下载中断
**解决**：
```bash
继续下载：
yt-dlp --continue "URL"

忽略错误继续：
yt-dlp -i "URL"
```

#### 连接超时
**解决**：
```bash
增加超时时间：
yt-dlp --socket-timeout 60 "URL"
```

## 依赖要求

### 必需
- **yt-dlp** - 核心下载工具

### 强烈推荐
- **ffmpeg** - 用于合并音视频、格式转换
- **ffprobe** - 视频信息提取工具

### 可选
- **Node.js** - JavaScript 运行时（YouTube 需要）
- **Deno** - 替代 JavaScript 运行时
- **Bun** - 高性能 JavaScript 运行时

### 安装依赖

#### 安装 yt-dlp
```bash
Windows: 从 GitHub Releases 下载 yt-dlp.exe
Linux:   sudo curl -L https://github.com/yt-dlp/yt-dlp/releases/latest/download/yt-dlp -o /usr/local/bin/yt-dlp
macOS:   brew install yt-dlp
```

#### 安装 ffmpeg
```bash
Windows: 从 ffmpeg.org 下载或使用包管理器
Linux:   sudo apt install ffmpeg
macOS:   brew install ffmpeg
```

#### 安装 Node.js
```bash
从 nodejs.org 下载安装
或使用包管理器：brew install node
```

## 高级用法

### 批量下载

#### 从文件读取 URL
```bash
yt-dlp -a urls.txt
```

#### 下载多个 URL
```bash
yt-dlp "URL1" "URL2" "URL3"
```

### 元数据处理

#### 嵌入元数据
```bash
yt-dlp --embed-metadata "URL"
```

#### 嵌入缩略图
```bash
yt-dlp --write-thumbnail --embed-thumbnail "URL"
```

### 后处理

#### 转换视频格式
```bash
yt-dlp --recode-video mp4 "URL"
```

#### 转换音频格式
```bash
yt-dlp -x --audio-format mp3 --audio-quality 0 "URL"
```

## 配置文件

创建配置文件 `yt-dlp.conf`，内容示例：

```ini
# 默认输出格式
-f bestvideo+bestaudio

# 默认合并格式
--merge-output-format mp4

# 保存路径
-o ~/Videos/%(uploader)s/%(title)s.%(ext)s

# 下载字幕
--write-subs

# 下载缩略图
--write-thumbnail

# 使用 JS 运行时
--js-runtimes node

# Chrome 模拟
--impersonate chrome
```

## 更新和版本

### 更新 yt-dlp
```bash
yt-dlp -U
```

### 切换到夜间版本
```bash
yt-dlp --update-to nightly
```

### 查看版本
```bash
yt-dlp --version
```

## 最佳实践

1. **首次使用**：先用 `yt-dlp -F URL` 查看可用格式
2. **YouTube 下载**：始终添加 `--js-runtimes node` 参数
3. **高质量需求**：使用 `bestvideo+bestaudio` + `--merge-output-format mp4`
4. **音频提取**：使用 `-x --audio-format mp3`
5. **批量处理**：创建 URL 列表文件，使用 `yt-dlp -a urls.txt`
6. **网络不稳定**：添加 `-i` 忽略错误，使用 `--continue` 断点续传

## 常用快捷命令速查

```bash
# 最佳质量视频
yt-dlp "URL"

# 1080p MP4
yt-dlp -f "bestvideo[height<=1080]+bestaudio" --merge-output-format mp4 "URL"

# 音频 MP3
yt-dlp -x --audio-format mp3 "URL"

# 播放列表 1080p
yt-dlp -f "bestvideo[height<=1080]+bestaudio" --merge-output-format mp4 "PLAYLIST_URL"

# 下载字幕和缩略图
yt-dlp --write-subs --write-thumbnail "URL"

# YouTube 推荐
yt-dlp --js-runtimes node --impersonate chrome "URL"

# 自定义路径
yt-dlp -o "~/Videos/%(uploader)s/%(title)s.%(ext)s" "URL"

# 查看详细信息
yt-dlp --dump-json "URL"
```

## 技巧提示

- 使用 `yt-dlp --print "%(title)s\n%(uploader)s" URL` 仅获取信息不下载
- 使用 `yt-dlp --playlist-items 1-5 URL` 下载播放列表特定项目
- 使用 `yt-dlp --cookies-from-browser chrome URL` 使用浏览器 Cookie
- 使用 `yt-dlp --download-archive archive.txt` 记录已下载视频，避免重复
- 使用 `yt-dlp --sub-langs zh-Hans,zh-Hant,en` 下载指定语言字幕

## 许可证

本 Skill 遵循 Unlicense 许可证，基于 yt-dlp 项目开发。

## 相关链接

- [yt-dlp GitHub](https://github.com/yt-dlp/yt-dlp)
- [yt-dlp 官方文档](https://github.com/yt-dlp/yt-dlp/blob/master/README.md)
- [支持的网站列表](https://github.com/yt-dlp/yt-dlp/blob/master/supportedsites.md)
- [yt-dlp Wiki](https://github.com/yt-dlp/yt-dlp/wiki)
