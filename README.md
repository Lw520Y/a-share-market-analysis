# A 股市场全景分析 — 通用 AI Agent 技能

> **用途**：任何 AI agent（WorkBuddy / Claude / GPT / Cursor / 通义 / Kimi 等）加载本目录后，即可完成 A 股市场的系统性分析并产出 HTML 研报。
>
> **核心理念**：分析方法论、判断标准、输出模板与平台无关。数据检索按当前 agent 环境选择可用工具。

## 快速开始（任何 Agent 通用）

### 如果你的 Agent 支持 Skill / 工作流

直接使用 `SKILL.md`（标准 frontmatter 格式，兼容 Claude Skills / WorkBuddy / OpenAI GPT 等）。

### 如果你的 Agent 只能读文档

1. 将本目录下所有 `.md` 文件作为上下文/知识库提供给 Agent
2. 对 Agent 说：**"请按照这个 SOP 分析最近一周 A 股市场"**
3. Agent 会按 `SKILL.md` 的八步流程执行

### 如果你只有对话窗口

复制以下 prompt 给任何 AI：

```
请根据以下方法论分析最近一周 A 股市场，产出 HTML 研报：

1. 获取数据：检索最近一周上证指数、深证成指、创业板指涨跌幅、成交额、
   涨跌家数、行业涨跌、资金流向、主力资金、融资余额
2. 按六大模块分析：市场状态（广度+量能）、板块轮动（横向比较）、
   主线识别（真伪主线）、资金面、宏观传导链、估值定位
3. 用市场档位决策树判断：进攻/震荡/防守/切换
4. 反转确认需三信号共振：量能>2万亿 + 融资余额止跌 + 广度>50%
5. 产出 HTML 研报（浅底深字、红涨绿跌、ECharts 图表）
6. 末尾附免责声明
```

## 目录结构

```
a-share-market-analysis/
├── README.md                          ← 本文件（通用入口）
├── SKILL.md                           ← 标准 skill 格式（触发 + 八步流程）
├── references/
│   ├── analysis-framework.md          ← 六大分析模块框架与指标阈值
│   ├── data-retrieval.md              ← 数据检索策略（多平台工具映射）
│   ├── judgment-criteria.md           ← 判断标准与决策树
│   └── output-template.md             ← HTML 研报模板 + ECharts 骨架
└── scripts/
    └── check_js_syntax.sh             ← JS 语法自检
```

## 各文件说明

| 文件 | 平台兼容性 | 说明 |
|---|---|---|
| `SKILL.md` | Claude Skills / WorkBuddy / GPT Actions | 标准 skill 格式，含 YAML frontmatter |
| `references/analysis-framework.md` | **全平台通用** | 纯方法论文档 |
| `references/data-retrieval.md` | **全平台通用** | 含 WorkBuddy / Claude / GPT 多平台工具映射 |
| `references/judgment-criteria.md` | **全平台通用** | 纯决策标准 |
| `references/output-template.md` | **全平台通用** | HTML/CSS/ECharts 模板 |
| `scripts/check_js_syntax.sh` | 任何有 Node.js 的环境 | shell 脚本 |

## 核心方法论概览

### 六大分析模块

| 模块 | 核心问题 | 关键指标 |
|---|---|---|
| 市场状态 | 处于什么阶段？ | 指数涨跌、广度、量能、涨跌分布 |
| 板块比较 | 哪个板块优先？ | 核心逻辑、交易位置、催化强度、资金偏好 |
| 主线识别 | 在交易什么？ | 真主线 vs 脉冲、龙头梯队、情绪周期 |
| 资金面 | 钱在进出吗？ | 主力资金、融资余额、ETF 净流入 |
| 宏观传导 | 什么在驱动？ | 宏观变量→中间变量→行业传导链 |
| 估值定位 | 贵还是便宜？ | PE/PB 分位、风格指数 |

### 判断阈值速查

| 指标 | 偏热 | 偏冷 | 分界 |
|---|---|---|---|
| 成交额 | > 2 万亿 | < 1.4 万亿 | 1.4-2.0 = 存量博弈 |
| 涨跌占比 | > 60% | < 30% | 30-60% = 震荡 |
| 融资余额 | 连升 | 连降 > 3 日 | — |
| 反转确认 | 三信号共振 | 任一缺失 | 量能+杠杆+广度 |

### 输出规范

- **格式**：HTML 研报（`<topic>-<YYYYMMDD>.html`）
- **风格**：浅底深字研报风，A 股**红涨绿跌**
- **结构**：TL;DR → KPI → 五大分析板块 → 观察清单 → 来源 → 免责声明
- **自检**：JS 语法检查通过后交付

## 免责声明（固定文案，禁止改写）

> **免责声明**：以上内容基于公开数据和量化分析，仅供参考，不构成投资建议。市场有风险，投资需谨慎。任何投资决策应结合个人风险承受能力、资金状况和投资目标独立判断，必要时咨询持牌专业机构。过往表现不预示未来收益。

---

*本技能适用于任何 AI agent 平台。分析方法论与平台无关，数据检索按当前环境选择可用工具。*
