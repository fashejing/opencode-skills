---
name: pigeondownloader
description: 使用 yt-dlp 下载视频、音频，支持 YouTube、Bilibili 等 1000+ 网站的视频下载
license: Unlicense
compatibility: opencode
metadata:
  author: pigeondownloader
  version: 1.0.0
  category: media-downloader
---

# PigeonDownloader - 视频下载 Skill

使用 yt-dlp 命令行工具从 1000+ 网站下载视频、音频和播放列表。

## 基本使用

### 下载单个视频
```bash
# 下载最佳质量（推荐）
yt-dlp "URL"

# 下载指定格式
yt-dlp -f "bestvideo[height<=1080]+bestaudio" "URL"

# 查看可用格式
yt-dlp -F "URL"
```

### 提取音频
```bash
# 提取为 MP3
yt-dlp -x --audio-format mp3 "URL"

# 提取为最佳音质
yt-dlp -x --audio-format best "URL"

# 支持的音频格式: aac, alac, flac, m4a, mp3, opus, vorbis, wav
```

### 下载播放列表
```bash
# 下载整个播放列表
yt-dlp "PLAYLIST_URL"

# 下载特定范围
yt-dlp --playlist-start 1 --playlist-end 10 "PLAYLIST_URL"

# 仅获取列表信息
yt-dlp --flat-playlist "PLAYLIST_URL"
```

## 高级选项

### 质量和格式选择
```bash
# 选择最佳 1080p
yt-dlp -f "bestvideo[height<=1080]+bestaudio" "URL"

# 选择最佳质量
yt-dlp -f "bestvideo+bestaudio" "URL"

# 选择 MP4 格式
yt-dlp -f "bestvideo[ext=mp4]+bestaudio[ext=m4a]" "URL"

# 使用排序规则
yt-dlp -S "res:1080" "URL"
yt-dlp -S "res:1080,ext:mp4" "URL"
```

### 自定义输出路径
```bash
# 自定义文件名
yt-dlp -o "%(title)s.%(ext)s" "URL"

# 按频道分类
yt-dlp -o "%(uploader)s/%(title)s.%(ext)s" "URL"

# 按上传日期分类
yt-dlp -o "%(upload_date)s/%(title)s.%(ext)s" "URL"

# 保存到指定目录
yt-dlp -o "~/Videos/%(title)s.%(ext)s" "URL"
```

### 字幕和缩略图
```bash
# 下载字幕
yt-dlp --write-subs "URL"

# 下载所有语言的字幕
yt-dlp --write-subs --sub-langs all "URL"

# 下载自动生成字幕
yt-dlp --write-auto-subs "URL"

# 下载缩略图
yt-dlp --write-thumbnail "URL"

# 嵌入缩略图到视频文件
yt-dlp --write-thumbnail --embed-thumbnail "URL"
```

### 元数据
```bash
# 嵌入元数据
yt-dlp --embed-metadata "URL"

# 嵌入字幕到视频
yt-dlp --embed-subs "URL"

# 下载并嵌入所有
yt-dlp --write-subs --write-thumbnail --embed-subs --embed-thumbnail --embed-metadata "URL"
```

### 后处理
```bash
# 合并为 MP4
yt-dlp --merge-output-format mp4 "URL"

# 转换视频格式
yt-dlp --recode-video mp4 "URL"

# 转换音频格式
yt-dlp -x --audio-format mp3 --audio-quality 0 "URL"
```

### 网络和代理
```bash
# 使用 HTTP 代理
yt-dlp --proxy http://127.0.0.1:8080 "URL"

# 使用 SOCKS5 代理
yt-dlp --proxy socks5://127.0.0.1:1080 "URL"

# 限制下载速度
yt-dlp --limit-rate 2M "URL"

# 设置超时
yt-dlp --socket-timeout 60 "URL"
```

## 输出模板变量

常用变量：
- `%(title)s` - 视频标题
- `%(uploader)s` - 上传者/频道名
- `%(id)s` - 视频 ID
- `%(ext)s` - 文件扩展名
- `%(upload_date)s` - 上传日期 (YYYYMMDD)
- `%(duration)s` - 时长（秒）
- `%(view_count)s` - 观看次数
- `%(like_count)s` - 点赞数
- `%(description)s` - 视频描述
- `%(channel)s` - 频道名
- `%(playlist_index)s` - 播放列表中的序号
- `%(playlist_title)s` - 播放列表标题

示例模板：
```bash
yt-dlp -o "%(uploader)s/%(upload_date)s_%(title)s.%(ext)s" "URL"
```

## 格式选择指南

### 基本格式
- `best` - 最佳质量（默认，包含音视频）
- `bestvideo` - 最佳视频
- `bestaudio` - 最佳音频
- `worst` - 最差质量

### 格式组合
- `bestvideo+bestaudio` - 最佳视频+最佳音频（自动合并）
- `bestvideo[height<=1080]+bestaudio` - 最高 1080p 视频+最佳音频
- `(bestvideo+bestaudio)/best` - 优先合并，否则使用最佳单文件

### 按扩展名
- `mp4` - MP4 格式
- `webm` - WebM 格式
- `mp3` - MP3 音频
- `m4a` - M4A 音频

### 按分辨率
- `bestvideo[height<=720]` - 最高 720p
- `bestvideo[height<=1080]` - 最高 1080p
- `bestvideo[height<=1440]` - 最高 1440p
- `bestvideo[height<=2160]` - 最高 4K

## 常用命令示例

### YouTube
```bash
# 下载 YouTube 视频
yt-dlp "https://www.youtube.com/watch?v=xxxxx"

# 下载 1080p 视频
yt-dlp -f "bestvideo[height<=1080]+bestaudio" "https://www.youtube.com/watch?v=xxxxx"

# 下载播放列表
yt-dlp "https://www.youtube.com/playlist?list=xxxxx"
```

### Bilibili
```bash
# 下载 Bilibili 视频
yt-dlp "https://www.bilibili.com/video/BVxxxxx"

# 下载 Bilibili 播放列表
yt-dlp "https://www.bilibili.com/video/av123456/p1"
```

### 音频提取
```bash
# 从视频提取音频
yt-dlp -x --audio-format mp3 "URL"

# 高质量音频
yt-dlp -x --audio-format flac "URL"

# 批量提取
yt-dlp -x --audio-format mp3 "PLAYLIST_URL"
```

### 批量处理
```bash
# 从文件读取 URL 列表
yt-dlp -a urls.txt

# 下载多个 URL
yt-dlp "URL1" "URL2" "URL3"

# 批量转换格式
yt-dlp --recode-video mp4 "URL1" "URL2"
```

### 高级用法
```bash
# 下载后转换为 MP4
yt-dlp --merge-output-format mp4 "URL"

# 仅获取信息不下载
yt-dlp --skip-download --print "%(title)s\n%(uploader)s" "URL"

# 获取视频信息 JSON
yt-dlp --dump-json "URL"

# 继续中断的下载
yt-dlp --continue "URL"

# 覆盖已存在文件
yt-dlp --force-overwrites "URL"

# 使用不同的客户端模拟
yt-dlp --impersonate chrome "URL"
```

## JavaScript 运行时

某些网站（如 YouTube）需要 JavaScript 运行时：

```bash
# 检测到的运行时: node
# 使用 node 作为 JS 运行时
yt-dlp --js-runtimes node "URL"

# 如果遇到警告，添加此选项
yt-dlp --js-runtimes node --impersonate chrome "URL"
```

## 故障排除

### 警告: No supported JavaScript runtime
**解决方案**:
```bash
yt-dlp --js-runtimes node "URL"
```

### 格式缺失
**解决方案**:
```bash
# 添加 JS 运行时
yt-dlp --js-runtimes node "URL"

# 使用不同的客户端
yt-dlp --impersonate chrome "URL"

# 查看所有可用格式
yt-dlp -F "URL"
```

### 下载速度慢
**解决方案**:
```bash
# 增加并发片段
yt-dlp --concurrent-fragments 4 "URL"

# 使用代理
yt-dlp --proxy socks5://127.0.0.1:1080 "URL"

# 限制速度避免被限速
yt-dlp --limit-rate 1M "URL"
```

### 合并失败
**解决方案**:
```bash
# 确保 ffmpeg 已安装
# 指定输出格式
yt-dlp --merge-output-format mp4 "URL"

# 下载后转换
yt-dlp --recode-video mp4 "URL"
```

### 下载失败
**解决方案**:
```bash
# 更新 yt-dlp
yt-dlp -U

# 忽略错误继续
yt-dlp -i "URL"

# 查看详细日志
yt-dlp -v "URL"
```

### 文件名问题
**解决方案**:
```bash
# 限制文件名长度
yt-dlp --trim-filenames 50 "URL"

# 使用 ASCII 字符
yt-dlp --restrict-filenames "URL"

# Windows 兼容
yt-dlp --windows-filenames "URL"
```

## 使用流程

当用户提供视频链接时：

1. **识别视频源**
   - 判断是 YouTube、Bilibili 还是其他网站
   - 检查是否为播放列表

2. **询问用户需求**
   - 视频/音频/两者
   - 质量要求（1080p, 4K 等）
   - 输出格式（MP4, MKV, MP3 等）
   - 是否需要字幕/缩略图
   - 保存路径

3. **构建命令**
   - 根据需求选择合适的参数
   - 添加 JS 运行时选项（如需要）
   - 设置输出模板

4. **执行下载**
   - 运行 yt-dlp 命令
   - 监控下载进度

5. **返回结果**
   - 文件路径
   - 文件大小
   - 下载时长

## 常用快捷命令

```bash
# 最佳质量视频
yt-dlp "URL"

# 1080p 视频 + MP4 格式
yt-dlp -f "bestvideo[height<=1080]+bestaudio" --merge-output-format mp4 "URL"

# 提取音频为 MP3
yt-dlp -x --audio-format mp3 "URL"

# 下载播放列表（1080p MP4）
yt-dlp -f "bestvideo[height<=1080]+bestaudio" --merge-output-format mp4 "PLAYLIST_URL"

# 下载字幕和缩略图
yt-dlp --write-subs --write-thumbnail "URL"

# 自定义路径 + 1080p
yt-dlp -o "~/Videos/%(uploader)s/%(title)s.%(ext)s" -f "bestvideo[height<=1080]+bestaudio" "URL"
```

## 依赖要求

- **必需**: yt-dlp (已安装 v2025.12.08)
- **推荐**: ffmpeg (用于视频/音频合并和转换)
- **可选**: Node.js (已安装，用于 YouTube 等需要 JS 运行时的网站)
