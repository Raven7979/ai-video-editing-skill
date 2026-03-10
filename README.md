# AI Video Editing Skill

[中文说明](#中文说明) | [English](#english)

## 中文说明

`AI Video Editing Skill` 是一个面向口播视频的自动初剪技能，重点场景是单人口播、讲解、解说、知识分享类视频。

它的核心目标不是做复杂视频理解，而是在尽量少消耗 token 的前提下，把真正影响口播节奏的问题先解决掉：

- 重复重说
- 临时重讲
- 多余气口和停顿
- 剪后字幕复核
- 与口播稿比对

### 设计重点

这个技能刻意不依赖视觉识别，不走“逐帧看视频”的重型路线。

它主要基于以下工作流：

1. 先把视频转成字幕和转写文本
2. 基于语义相似度识别相邻重复、重说和试讲
3. 按用户选择的剪辑强度进行口播初剪
4. 初剪后重新转字幕
5. 如果用户提供了口播稿，再把剪后字幕和口播稿重新比对
6. 标出疑似大段 NG / 试讲 / 临场发挥，交给用户确认是否继续删

### 为什么这样做

- 更省 token：不依赖视觉识别，不做高成本多模态逐帧分析
- 更适合口播：口播问题大多出在“说法重复、节奏拖沓、重讲、气口”而不是画面内容
- 更容易批量化：同类口播视频可以快速统一处理
- 有稿效果更好：如果提供口播稿，系统能更稳地判断该保留哪一句、哪里可能误剪

### 适用场景

- 口播视频初剪
- 自媒体讲解视频
- 知识分享短视频
- 解说类出镜素材
- 需要快速做粗剪和字幕复核的内容团队

### 不适合直接硬剪的场景

- 多人物访谈
- 强依赖画面信息的 vlog / 纪录片 / 剧情内容
- 需要镜头语言、表情和动作判断的复杂剪辑

### 适用软件 / 兼容环境

这个技能本质上是一个 `SKILL.md + 本地脚本` 的工作流，因此最适合能直接调用本地 shell / Python / ffmpeg 的智能体环境。

当前可写进说明的适用范围：

- Codex / Codex Desktop
- Claude Code 风格的本地智能体环境
- 支持 Skills / SKILL.md 机制的本地 AI Agent 工作流

关于 `OpenClaw`：

- 如果 `OpenClaw` 支持读取 `SKILL.md`
- 并且可以调用本地 `bash / python / ffmpeg`
- 也支持把用户文件路径传给技能脚本

那么这套技能理论上可以接入 `OpenClaw`。

更准确地说：

- `Codex / Claude Code`：可直接使用或少量调整后使用
- `OpenClaw`：大概率可以适配，但是否“开箱即用”取决于它对技能包格式和本地脚本执行的支持程度

### 输出内容

- 原始转写：`.raw.txt`
- 校对稿：`.txt`
- 原始字幕：`.raw.srt`
- 初剪视频：`.roughcut.mp4`
- 初剪后重新转写：`.roughcut.raw.txt`
- 初剪后校对稿：`.roughcut.txt`
- 初剪后字幕：`.roughcut.srt`
- 剪辑报告：`.roughcut.json`

## English

`AI Video Editing Skill` is an automatic rough-cut workflow built for talking-head videos such as commentary, explainers, educational clips, and creator monologues.

Its goal is not full visual understanding. The goal is to solve the highest-value editing problems for spoken videos while keeping token usage low:

- repeated takes
- immediate restarts
- unnecessary pauses and breathing gaps
- subtitle regeneration after editing
- script comparison when a prepared script is available

### Design Focus

This skill deliberately avoids heavy visual analysis. It does not rely on frame-by-frame video understanding.

Instead, it uses a lightweight workflow:

1. transcribe the video into subtitles and text
2. detect semantic repetition, restarts, and likely rehearsal takes
3. create a rough cut based on the chosen editing intensity
4. re-transcribe the edited video
5. compare the edited transcript against the provided script if one exists
6. flag long likely NG / rehearsal / improvised sections for user confirmation

### Why this approach

- Token-efficient: avoids costly vision-first multimodal processing
- Better fit for talking-head editing: most issues are verbal, not visual
- Easy to scale: suitable for batch processing similar creator videos
- Better with a script: when a script is provided, the system can more reliably keep the better take and detect suspicious cuts

### Best Use Cases

- rough cuts for talking-head videos
- explainer content
- educational creator videos
- commentary and voice-led short videos
- teams that need fast first-pass editing plus subtitle verification

### Not ideal for direct automatic cutting

- multi-person interviews
- vlogs or documentaries that depend heavily on visuals
- cinematic edits requiring facial, gesture, and shot-language judgment

### Compatible Tools / Runtime Environments

This skill is essentially a `SKILL.md + local scripts` workflow, so it fits best in agent environments that can execute local shell, Python, and ffmpeg commands.

Reasonable compatibility notes:

- Codex / Codex Desktop
- Claude Code style local agent environments
- Local AI agent systems that support Skills or `SKILL.md`-based workflows

About `OpenClaw`:

If `OpenClaw` can:

- read `SKILL.md`
- execute local `bash / python / ffmpeg`
- pass user-provided file paths into the workflow

then this skill should be adaptable to `OpenClaw`.

More precisely:

- `Codex / Claude Code`: direct fit or very small adjustments
- `OpenClaw`: likely compatible, but whether it works out of the box depends on its support for skill packaging and local script execution

### Outputs

- raw transcript: `.raw.txt`
- cleaned transcript: `.txt`
- raw subtitles: `.raw.srt`
- rough-cut video: `.roughcut.mp4`
- re-transcribed rough-cut text: `.roughcut.raw.txt`
- cleaned rough-cut transcript: `.roughcut.txt`
- rough-cut subtitles: `.roughcut.srt`
- edit report: `.roughcut.json`
